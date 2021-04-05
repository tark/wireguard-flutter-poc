package pro.tark.wireguard_plugin

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import com.beust.klaxon.Klaxon
import com.wireguard.android.backend.Backend
import com.wireguard.android.backend.BackendException
import com.wireguard.android.backend.Tunnel
import com.wireguard.android.util.ModuleLoader
import com.wireguard.android.util.RootShell
import com.wireguard.android.util.ToolsInstaller
import com.wireguard.config.Config
import com.wireguard.config.Interface
import com.wireguard.config.Peer

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.coroutines.*
import java.util.*

/** WireguardPlugin */
class WireGuardPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private val permissionRequestCode = 10014
    private val futureBackend = CompletableDeferred<Backend>()
    private val scope = CoroutineScope(Job() + Dispatchers.Main.immediate)
    private var backend: Backend? = null
    private lateinit var moduleLoader: ModuleLoader
    private lateinit var rootShell: RootShell
    private lateinit var toolsInstaller: ToolsInstaller
    private var havePermission = false
    private var methodChannel: MethodChannel? = null

    // Have to keep tunnels, because WireGuard requires to use the _same_
    // instance of a tunnel every time you change the state.
    private var tunnels = HashMap<String, Tunnel>()

    companion object {
        const val TAG = "WireguardPlugin"
        val USER_AGENT = String.format(
                Locale.ENGLISH,
                "WireGuard/%s (Android %d; %s; %s; %s %s; %s)",
                // TODO: replace "1.0.2" by BuildConfig.VERSION_NAME,
                "1.0.2",
                Build.VERSION.SDK_INT,
                if (Build.SUPPORTED_ABIS.isNotEmpty()) Build.SUPPORTED_ABIS[0] else "unknown ABI",
                Build.BOARD,
                Build.MANUFACTURER,
                Build.MODEL,
                Build.FINGERPRINT
        )
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tark.pro/wireguard-flutter")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (!havePermission) {
            flutterError(result, "Have no permission to configure VPN")
            return
        }

        when (call.method) {
            "getTunnelNames" -> handleGetNames(result)
            "setState" -> handleSetState(call.arguments, result)
            "getStats" -> handleGetStats(call.arguments, result)
            else -> flutterNotImplemented(result)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun flutterSuccess(result: MethodChannel.Result, o: Any) {
        scope.launch(Dispatchers.Main) {
            result.success(o)
        }
    }

    private fun flutterError(result: MethodChannel.Result, error: String) {
        scope.launch(Dispatchers.Main) {
            result.error(error, null, null)
        }
    }

    private fun flutterNotImplemented(result: MethodChannel.Result) {
        scope.launch(Dispatchers.Main) {
            result.notImplemented()
        }
    }

    private fun handleSetState(arguments: Any, result: MethodChannel.Result) {

        scope.launch(Dispatchers.IO) {
            try {

                val params = Klaxon().parse<SetStateParams>(arguments.toString())

                if (params == null) {
                    flutterError(result, "Set state params is missing")
                    return@launch
                }

                val config = Config.Builder()
                        .setInterface(
                                Interface.Builder()
                                        .parseAddresses(params.tunnel.address)
                                        .parseListenPort(params.tunnel.listenPort)
                                        .parseDnsServers(params.tunnel.dnsServer)
                                        .parsePrivateKey(params.tunnel.privateKey)
                                        .build(),
                        )
                        .addPeer(
                                Peer.Builder()
                                        .parseAllowedIPs(params.tunnel.peerAllowedIp)
                                        .parsePublicKey(params.tunnel.peerPublicKey)
                                        .parseEndpoint(params.tunnel.peerEndpoint)
                                        .build()
                        )
                        .build()
                //futureBackend.await().setState(MyTunnel(params.tunnel.name), params.tuTunnel.State.UP, config)
                futureBackend.await().setState(
                        tunnel(params.tunnel.name) { state ->
                            scope.launch(Dispatchers.Main) {
                                Log.i(TAG, "onStateChange - $state")
                                methodChannel?.invokeMethod(
                                        "onStateChange",
                                        Klaxon().toJsonString(
                                                StateChangeData(params.tunnel.name, state == Tunnel.State.UP)
                                        )
                                )
                            }
                        },
                        if (params.state) Tunnel.State.UP else Tunnel.State.DOWN,
                        config
                )
                Log.i(TAG, "handleSetState - success!")
                flutterSuccess(result, true)
            } catch (e: BackendException) {
                Log.e(TAG, "handleSetState - BackendException - ERROR - ${e.reason}")
                flutterError(result, e.reason.toString())
            } catch (e: Throwable) {
                Log.e(TAG, "handleSetState - Can't set tunnel state: $e, ${Log.getStackTraceString(e)}")
                flutterError(result, e.message.toString())
            }
        }
    }

    private fun handleGetNames(result: MethodChannel.Result) {
        scope.launch(Dispatchers.IO) {
            try {
                val names = futureBackend.await().runningTunnelNames
                Log.i(TAG, "Success $names")
                flutterSuccess(result, names.toString())
            } catch (e: Throwable) {
                Log.e(TAG, "Can't get tunnel names: " + e.message + " " + e.stackTrace)
                flutterError(result, "Can't get tunnel names")
            }
        }
    }

    private fun handleGetStats(arguments: Any?, result: MethodChannel.Result) {
        val tunnelName = arguments?.toString()
        if (tunnelName == null || tunnelName.isEmpty()) {
            flutterError(result, "Provide tunnel name to get statistics")
            return
        }

        scope.launch(Dispatchers.IO) {

            try {
                val stats = futureBackend.await().getStatistics(tunnel(tunnelName))

                flutterSuccess(result, Klaxon().toJsonString(
                        Stats(stats.totalRx(), stats.totalTx())
                ))

            } catch (e: BackendException) {
                Log.e(TAG, "handleGetStats - BackendException - ERROR - ${e.reason}")
                flutterError(result, e.reason.toString())
            } catch (e: Throwable) {
                Log.e(TAG, "handleGetStats - Can't get stats: $e")
                flutterError(result, e.message.toString())
            }
        }
    }

    /**
     * Return existing [MyTunnel] from the [tunnels], or create new, add to the list and return it
     */
    private fun tunnel(name: String, callback: StateChangeCallback? = null): Tunnel {
        return tunnels.getOrPut(name, { MyTunnel(name, callback) })
    }
}

typealias StateChangeCallback = (Tunnel.State) -> Unit
