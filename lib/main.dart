import 'package:flutter/material.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:workshop2test/tester/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workshop2',
        home: OrderStatusScreen(orderId: 5));
  }
}
