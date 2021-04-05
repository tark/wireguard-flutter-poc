class TunnelStats {
  final num totalDownload;
  final num totalUpload;

  TunnelStats({
    required this.totalDownload,
    required this.totalUpload,
  });

  Map<String, dynamic> toJson() => {
        'totalDownload': totalDownload,
        'totalUpload': totalUpload,
      };

  factory TunnelStats.fromJson(Map<String, dynamic> json) {
    return TunnelStats(
      totalDownload: json['totalDownload'] as num,
      totalUpload: json['totalUpload'] as num,
    );
  }
}
