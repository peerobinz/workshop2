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
          child: Text('เมนู',
              style: TextStyle(
                color: Color.fromARGB(255, 110, 56, 5),
                fontSize: 30,
                fontFamily: 'Inter',
              )),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket,
              color: Color.fromARGB(255, 110, 56, 5), // เปลี่ยนสีไอคอน
              size: 40.0, // เปลี่ยนขนาดไอคอน
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
            color: Color.fromARGB(255, 110, 56, 5), // เปลี่ยนสีไอคอน
            size: 40.0, // เปลี่ยนขนาดไอคอน
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
              // onChanged: (value) {
              //   // ใส่โค้ดที่ต้องการเมื่อมีการเปลี่ยนค่าใน TextField
              // },
            ),
          ),
          // ตัวอย่างเนื้อหาต่อที่คุณต้องการแสดงในหน้าจอ
          // เช่น รายการอาหาร, รูปภาพ, และอื่น ๆ
        ],
      ),
    );
  }
}
