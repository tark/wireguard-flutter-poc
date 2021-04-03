package com.example.wireguard_flutter

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import com.beust.klaxon.Klaxon
import com.wireguard.android.backend.*
import com.wireguard.android.util.ModuleLoader
import com.wireguard.android.util.RootShell
import com.wireguard.android.util.ToolsInstaller
import com.wireguard.config.Config
import com.wireguard.config.Interface
import com.wireguard.config.Peer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.util.*

class MainActivity : FlutterActivity() {

  private val permissionRequestCode = 10014
  private val channel = "tark.pro/wireguard-flutter"
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
    const val TAG = "MainActivity"
    val USER_AGENT = String.format(
      Locale.ENGLISH,
      "WireGuard/%s (Android %d; %s; %s; %s %s; %s)",
      BuildConfig.VERSION_NAME,
      Build.VERSION.SDK_INT,
      if (Build.SUPPORTED_ABIS.isNotEmpty()) Build.SUPPORTED_ABIS[0] else "unknown ABI",
      Build.BOARD,
      Build.MANUFACTURER,
      Build.MODEL,
      Build.FINGERPRINT
    )
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
    methodChannel?.setMethodCallHandler { call, result ->

      if (!havePermission) {
        flutterError(result, "Have no permission to configure VPN")
        return@setMethodCallHandler
      }

      when (call.method) {
        "getTunnelNames" -> handleGetNames(result)
        "setState" -> handleSetState(call.arguments, result)
        "getStats" -> handleGetStats(call.arguments, result)
        else -> flutterNotImplemented(result)
      }

    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    havePermission = (requestCode == permissionRequestCode) && (resultCode == Activity.RESULT_OK)
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    rootShell = RootShell(applicationContext)
    toolsInstaller = ToolsInstaller(applicationContext, rootShell)
    moduleLoader = ModuleLoader(applicationContext, rootShell, USER_AGENT)

    scope.launch(Dispatchers.IO) {
      try {
        backend = createBackend()
        futureBackend.complete(backend!!)
        checkPermission()
      } catch (e: Throwable) {
        Log.e(TAG, Log.getStackTraceString(e))
      }
    }
  }

  //
  private fun createBackend(): Backend {
    var backend: Backend? = null
    var didStartRootShell = false
    if (!ModuleLoader.isModuleLoaded() && moduleLoader.moduleMightExist()) {
      try {
        rootShell.start()
        didStartRootShell = true
        moduleLoader.loadModule()
      } catch (ignored: Exception) {
        Log.e(TAG, Log.getStackTraceString(ignored))
      }
    }
    if (ModuleLoader.isModuleLoaded()) {
      try {
        if (!didStartRootShell) {
          rootShell.start()
        }
        val wgQuickBackend = WgQuickBackend(applicationContext, rootShell, toolsInstaller)
        //wgQuickBackend.setMultipleTunnels(UserKnobs.multipleTunnels.first())
        backend = wgQuickBackend
        // what is that? I totally did not understand
        /*UserKnobs.multipleTunnels.onEach {
          wgQuickBackend.setMultipleTunnels(it)
        }.launchIn(coroutineScope)*/
      } catch (ignored: Exception) {
        Log.e(TAG, Log.getStackTraceString(ignored))
      }
    }
    if (backend == null) {
      backend = GoBackend(applicationContext)
    }
    return backend
  }

  private fun checkPermission() {
    val intent = GoBackend.VpnService.prepare(this)
    if (intent != null) {
      havePermission = false
      startActivityForResult(intent, permissionRequestCode)
    } else {
      havePermission = true
    }
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

class MyTunnel(private val name: String,
               private val onStateChanged: StateChangeCallback? = null) : Tunnel {

  override fun getName() = name

  override fun onStateChange(newState: Tunnel.State) {
    onStateChanged?.invoke(newState)
  }

}

class SetStateParams(
  val state: Boolean,
  val tunnel: TunnelData
)

class TunnelData(
  val name: String,
  val address: String,
  val listenPort: String,
  val dnsServer: String,
  val privateKey: String,
  val peerAllowedIp: String,
  val peerPublicKey: String,
  val peerEndpoint: String,
)

class StateChangeData(
  val tunnelName: String,
  val tunnelState: Boolean,
)

class Stats(
  val totalDownload: Long,
  val totalUpload: Long,
)
