import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'log.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WireGuard PoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _tunnelNames = '';
  static const platform = const MethodChannel('tark.pro/wireguard-flutter');

  /*@override
  void initState() {
    super.initState();
    _setState().then((_) {
      _getTunnelNames();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WireGuard PoC'),
      ),
      body: Column(
        children: [
          Text(_tunnelNames),
          ElevatedButton(
            child: Text('Create a tunnel'),
            onPressed: () => _setState(context),
          ),
          ElevatedButton(
            child: Text('Get tunnels'),
            onPressed: () => _getTunnelNames(context),
          ),
        ],
      ),
    );
  }

  Future _setState(BuildContext context) async {
    try {
      final result = await platform.invokeMethod('setState');
      l('_setState', result);
    } on PlatformException catch (e) {
      l('_setState', e.toString());
      _showError(context, e.toString());
    }
  }

  _getTunnelNames(BuildContext context) async {
    try {
      final result = await platform.invokeMethod('getTunnelNames');
      l('_getTunnelNames', result);
    } on PlatformException catch (e) {
      l('_getTunnelNames', e.toString());
      _showError(context, e.toString());
    }
  }

  _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }
}
