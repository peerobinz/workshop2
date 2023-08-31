//import screen
import 'package:flutter/material.dart';

//import widget

//import add-on
class OrderConfirm extends StatefulWidget {
  const OrderConfirm({super.key});

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'รายการอาหาร',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 50,
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 110, 56, 5)),
        ),
        centerTitle: true,
      ),
    );
  }
}
