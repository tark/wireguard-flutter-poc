package pro.tark.wireguard_plugin

import com.wireguard.android.backend.Tunnel


class MyTunnel(private val name: String,
               private val onStateChanged: StateChangeCallback? = null) : Tunnel {

    override fun getName() = name

    override fun onStateChange(newState: Tunnel.State) {
        onStateChanged?.invoke(newState)
    }

}