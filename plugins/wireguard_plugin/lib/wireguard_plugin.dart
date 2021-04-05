import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wireguard_plugin/model/tunnel_stats.dart';

import 'model/set_state_params.dart';
import 'model/state_change_data.dart';
import 'model/tunnel.dart';

class WireguardPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tark.pro/wireguard-flutter');

  /// no need to close, since it's static controller
  // ignore: close_sinks
  static final _tunnelsStateController =
      StreamController<StateChangeData>.broadcast();

  static Stream<StateChangeData> get tunnelState =>
      _tunnelsStateController.stream;

  static Future<bool> requestPermission() async {
    print('WireguardPlugin requestPermission ');
    final result = await _channel.invokeMethod('requestPermission');
    print('WireguardPlugin requestPermission $result');
    return result;
  }

  static Future<bool> initialize() async {
    print('WireguardPlugin initialize');
    _channel.setMethodCallHandler((call) async {
      print('WireguardPlugin MethodCallHandler $call');
      switch (call.method) {
        case 'onStateChange':
          try {
            final stats = StateChangeData.fromJson(
              jsonDecode(call.arguments),
            );
            _tunnelsStateController.add(stats);
          } catch (e, s) {
            print('wireguard plugin setMethodCallHandler error: $e');
            print(s);
          }

          break;
      }
    });
    final result = await _channel.invokeMethod('initialize');
    print('WireguardPlugin initialize $result');
    return result;
  }

  static Future setState({
    required bool isConnected,
    required Tunnel tunnel,
  }) async {
    print('WireguardPlugin setState');
    final result = await _channel.invokeMethod(
      'setState',
      jsonEncode(SetStateParams(
        state: isConnected,
        tunnel: tunnel,
      ).toJson()),
    );
    print('WireguardPlugin setState $result');
    return result;
  }

  static Future getTunnelNames() async {
    print('WireguardPlugin getTunnelNames ');
    final result = await _channel.invokeMethod('getTunnelNames');
    print('WireguardPlugin getTunnelNames $result');
    return result;
  }

  static Future<TunnelStats> getTunnelUsageStats(String tunnelName) async {
    print('WireguardPlugin getTunnelUsageStats $tunnelName');
    final result = await _channel.invokeMethod('getStats', tunnelName);
    final stats = TunnelStats.fromJson(jsonDecode(result));
    print('WireguardPlugin getTunnelUsageStats $stats');
    return stats;
  }
}
