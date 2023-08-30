import 'package:flutter/material.dart';
import 'package:workshop2test/screen/MainManuSC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // นำแบนเนอร์ debug ออก
      title: 'Workshop2',
      home: MainMenu(),
    );
  }
}
