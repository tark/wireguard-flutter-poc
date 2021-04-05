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

  static bool _callHandlerWasInitialized = false;

  /// no need to close, since it's static controller
  // ignore: close_sinks
  static final _tunnelsStateController = StreamController.broadcast();

  static Stream get tunnelState => _tunnelsStateController.stream;

  static initialize() {
    _channel.setMethodCallHandler((call) async {
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
  }

  static Future setState({
    required bool isConnected,
    required Tunnel tunnel,
  }) async {
    final result = await _channel.invokeMethod(
      'setState',
      jsonEncode(SetStateParams(
        state: isConnected,
        tunnel: tunnel,
      ).toJson()),
    );
    return result;
  }

  static Future getTunnelNames() async {
    final result = await _channel.invokeMethod('getTunnelNames');
    return result;
  }

  static Future<TunnelStats> getTunnelUsageStats(String tunnelName) async {
    final result = await _channel.invokeMethod('getStats', tunnelName);
    final stats = TunnelStats.fromJson(jsonDecode(result));
    return stats;
  }
}
