/*
class SetStateParams {
  final bool state;
  final Tunnel tunnel;

  SetStateParams({
    required this.state,
    required this.tunnel,
  });

  Map<String, dynamic> toJson() => {
        'state': state,
        'tunnel': tunnel.toJson(),
      };
}

class Tunnel {
  final String name;
  final String address;
  final String listenPort;
  final String dnsServer;
  final String privateKey;
  final String peerAllowedIp;
  final String peerPublicKey;
  final String peerEndpoint;

  Tunnel({
    required this.name,
    required this.address,
    required this.listenPort,
    required this.dnsServer,
    required this.privateKey,
    required this.peerAllowedIp,
    required this.peerPublicKey,
    required this.peerEndpoint,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'listenPort': listenPort,
        'dnsServer': dnsServer,
        'privateKey': privateKey,
        'peerAllowedIp': peerAllowedIp,
        'peerPublicKey': peerPublicKey,
        'peerEndpoint': peerEndpoint,
      };
}

class StateChangeData {
  final String tunnelName;
  final bool tunnelState;

  StateChangeData({
    required this.tunnelName,
    required this.tunnelState,
  });

  Map<String, dynamic> toJson() => {
        'tunnelName': tunnelName,
        'tunnel': tunnelState,
      };

  factory StateChangeData.fromJson(Map<String, dynamic> json) {
    return StateChangeData(
      tunnelName: json['tunnelName'] as String,
      tunnelState: (json['tunnelState'] as bool?) ?? false,
    );
  }
}

class Stats {
  final num totalDownload;
  final num totalUpload;

  Stats({
    required this.totalDownload,
    required this.totalUpload,
  });

  Map<String, dynamic> toJson() => {
        'totalDownload': totalDownload,
        'totalUpload': totalUpload,
      };

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalDownload: json['totalDownload'] as num,
      totalUpload: json['totalUpload'] as num,
    );
  }
}

 */
