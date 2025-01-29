import 'package:flutter/material.dart';
import 'package:flutter_svga/flutter_svga.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter SVGA Example")),
        body: Center(
          child: SVGAEasyPlayer(
            assetsName: "assets/sample.svga",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
