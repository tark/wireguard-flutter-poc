import 'package:flutter/material.dart';
import 'package:wireguard_flutter/ui/tunnel_details.dart';

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
      home: TunnelDetails(),
    );
  }
}
