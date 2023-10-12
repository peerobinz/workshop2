import 'package:flutter/material.dart';

class MyText {
  static const TextStyle basic = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: Color(0xFF823D32),
  );

  static const TextStyle headline = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: Color(0xFF823D32),
  );

  static TextStyle subheading = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Color(0xFF823D32),
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Color(0xFF823D32),
  );

  static const TextStyle buttoncomfirm = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: Color.fromARGB(255, 249, 249, 249),
  );

  static const TextStyle buttonpayment = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: 25,
    color: Color.fromARGB(255, 249, 249, 249),
  );
}
