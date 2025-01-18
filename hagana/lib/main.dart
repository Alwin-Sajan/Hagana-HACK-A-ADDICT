import 'package:flutter/material.dart';
import 'package:hagana/pages/Welcomescren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hagana App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Welcomescreen(), // Set Welcomescreen as the initial screen
    );
  }
}