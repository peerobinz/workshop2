//import screen
import 'package:flutter/material.dart';
import 'package:workshop2test/screen/MainManuSC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workshop2',
      home: MainMenu(),
    );
  }
}
