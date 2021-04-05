package pro.tark.wireguard_plugin

class TunnelData(
        val name: String,
        val address: String,
        val listenPort: String,
        val dnsServer: String,
        val privateKey: String,
        val peerAllowedIp: String,
        val peerPublicKey: String,
        val peerEndpoint: String
)