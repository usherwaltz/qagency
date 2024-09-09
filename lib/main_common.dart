import 'package:flutter/material.dart';

import 'flavor_config.dart';

Future<void> mainCommon() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorConfig.instance.values.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(FlavorConfig.instance.values.appTitle),
        ),
        body: Center(
          child: Text(FlavorConfig.instance.values.appTitle),
        ),
      ),
    );
  }
}
