//import screen
import 'package:flutter/material.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:workshop2test/screen/Order_ConfirmSC.dart';

//import widget

//import add-on

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'เมนู',
            style: TextStyle(
              color: Color.fromARGB(255, 110, 56, 5),
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket,
              color: Color.fromARGB(255, 110, 56, 5),
              size: 40.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderConfirm()),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Color.fromARGB(255, 110, 56, 5),
            size: 40.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()),
            );
          },
        ),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาเมนูอาหาร',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft, // จัดตำแหน่งอยู่ทางด้านซ้าย
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0), // ให้ระยะห่างด้านซ้าย
              child: Text(
                'รายการอาหาร',
                style: TextStyle(
                  color: Color.fromARGB(255, 110, 56, 5),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
