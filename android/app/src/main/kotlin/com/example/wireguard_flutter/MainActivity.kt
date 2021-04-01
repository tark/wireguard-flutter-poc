package com.example.wireguard_flutter

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import com.wireguard.android.backend.*
import com.wireguard.android.util.ModuleLoader
import com.wireguard.android.util.RootShell
import com.wireguard.android.util.ToolsInstaller
import com.wireguard.config.Config
import com.wireguard.config.InetNetwork
import com.wireguard.config.Interface
import com.wireguard.config.Peer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.lang.ref.WeakReference
import java.net.InetAddress
import java.util.*

class MainActivity : FlutterActivity() {

  /*private val permissionActivityResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
    toggleTunnelWithPermissionsResult()
  }*/

  private val permissionRequestCode = 10014
  private val channel = "tark.pro/wireguard-flutter"
  private val futureBackend = CompletableDeferred<Backend>()
  private val scope = CoroutineScope(Job() + Dispatchers.Main.immediate)
  private var backend: Backend? = null
  private lateinit var moduleLoader: ModuleLoader
  private lateinit var rootShell: RootShell
  private lateinit var toolsInstaller: ToolsInstaller
  private var havePermission = false

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
      scope.launch {

        if (!havePermission) {
          result.error("Have no permission to configure VPN", null, null)
          return@launch
        }

        when (call.method) {
          "getTunnelNames" -> {
            try {
              val names = futureBackend.await().runningTunnelNames
              Log.i(TAG, "Success $names")
              result.success(names.toString())
            } catch (e: Throwable) {
              Log.e(TAG, "Can't get tunnel names: " + e.message + " " + e.stackTrace)
              result.error("Can't get tunnel names", null, null)
            }
          }
          "setState" -> {
            try {

              val config = Config.Builder()
                .setInterface(
                  Interface.Builder()
                    .parseAddresses("10.200.200.185")
                    .parseListenPort("51820")
                    .parseDnsServers("116.203.231.122")
                    .parsePrivateKey("mIWKevXKBlBxXEAtzJJtLOU0TjSduvvm9rUQpvdPBkM=")
                    .build(),
                )
                .addPeer(
                  Peer.Builder()
                    .parseAllowedIPs("0.0.0.0/0")
                    .parsePublicKey("9Xhc/RmDmmyy54+F/mhSh1KEV0/bjD6ruAp934pmlDk=")
                    .parseEndpoint("wghongkong01.spidervpnservers.com:443")
                    .build()
                )
                .build()

              Log.i(TAG, "onOptionsItemSelected interface - ${config.`interface`.addresses}")
              Log.i(TAG, "onOptionsItemSelected interface - ${config.`interface`.dnsServers}")
              Log.i(TAG, "onOptionsItemSelected interface - ${config.`interface`.keyPair.privateKey.toBase64()}")
              Log.i(TAG, "onOptionsItemSelected interface - ${config.`interface`.keyPair.publicKey.toBase64()}")
              Log.i(TAG, "onOptionsItemSelected interface - ${config.`interface`.listenPort.get()}")
              Log.i(TAG, "onOptionsItemSelected -------")
              Log.i(TAG, "onOptionsItemSelected peer - ${config.peers[0].allowedIps}")
              Log.i(TAG, "onOptionsItemSelected peer - ${config.peers[0].endpoint.get()}")
              Log.i(TAG, "onOptionsItemSelected peer - ${config.peers[0].publicKey.toBase64()}")
              //scope.launch {
                futureBackend.await().setState(MyTunnel("example-tunnel"), Tunnel.State.TOGGLE, config)
                Log.i(TAG, "setState - success!")
                result.success("setState - success!")
              //}

            } catch (e: BackendException) {
              Log.e(TAG, "setState - BackendException - ERROR - ${e.reason}")
              result.error("setState - BackendException - ERROR - ${e.reason}", null, null)
            } catch (e: Throwable) {
              Log.e(TAG, "Can't set tunnel state: $e")
              result.error("setState - ERROR - ${e.message}", null, null)
            }
          }
          else -> {
            result.notImplemented()
          }
        }
      }
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    Log.i(TAG, "onActivityResult - $requestCode - $resultCode")
    super.onActivityResult(requestCode, resultCode, data)
    havePermission = (requestCode == permissionRequestCode) && (resultCode == Activity.RESULT_OK)
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Log.i(TAG, "onCreate")
    rootShell = RootShell(applicationContext)
    toolsInstaller = ToolsInstaller(applicationContext, rootShell)
    moduleLoader = ModuleLoader(applicationContext, rootShell, USER_AGENT)

    scope.launch(Dispatchers.IO) {
      try {
        backend = determineBackend()
        futureBackend.complete(backend!!)
        checkPermission()
      } catch (e: Throwable) {
        Log.e(TAG, Log.getStackTraceString(e))
      }
    }
  }

  private fun determineBackend(): Backend {
    Log.i(TAG, "determineBackend")
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
    if (/*!UserKnobs.disableKernelModule.first() &&*/ ModuleLoader.isModuleLoaded()) {
      try {
        if (!didStartRootShell) {
          rootShell.start()
        }
        val wgQuickBackend = WgQuickBackend(applicationContext, rootShell, toolsInstaller)
        //wgQuickBackend.setMultipleTunnels(UserKnobs.multipleTunnels.first())
        backend = wgQuickBackend
        Log.i(TAG, "--> WG QUICK BACKEND <--")

        // what is that? I totally did not understand
        /*UserKnobs.multipleTunnels.onEach {
          wgQuickBackend.setMultipleTunnels(it)
        }.launchIn(coroutineScope)*/
      } catch (ignored: Exception) {
        Log.e(TAG, Log.getStackTraceString(ignored))
      }
    }
    if (backend == null) {
      Log.i(TAG, "--> GO BACKEND <--")
      backend = GoBackend(applicationContext)
      // the blow line is very important, it returns the callback from the GoBackend
      //GoBackend.setAlwaysOnCallback { get().applicationScope.launch { get().tunnelManager.restoreState(true) } }
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

    private lateinit var weakSelf: WeakReference<MainActivity>

    @JvmStatic
    fun get(): MainActivity {
      return weakSelf.get()!!
    }

    //@JvmStatic
    //suspend fun getBackend() = get().futureBackend.await()

    @JvmStatic
    fun getModuleLoader() = get().moduleLoader

    @JvmStatic
    fun getRootShell() = get().rootShell

    //@JvmStatic
    //fun getPreferencesDataStore() = get().preferencesDataStore

    @JvmStatic
    fun getToolsInstaller() = get().toolsInstaller

    //@JvmStatic
    //fun getTunnelManager() = get().tunnelManager

    @JvmStatic
    fun getCoroutineScope() = get().scope

  }

}

class MyTunnel(private val name: String) : Tunnel {

  override fun getName() = name

  override fun onStateChange(newState: Tunnel.State) {
    Log.i("MyTunnel", "onStateChange $newState")
  }

}
