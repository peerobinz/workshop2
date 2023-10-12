import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),

      // สร้างแถบนำทางแนวตั้ง
      body: Stack(
        children: <Widget>[
          // สร้างพื้นหลังสีเทาสำหรับปิดเมนู
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              color: Colors.grey[200],
              width: 60, // กำหนดความกว้างของแถบนำทาง
            ),
          ),
          // เมนูแถบนำทาง
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    // เพิ่มโค้ดที่คุณต้องการเมื่อเลือก "Home"
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // เพิ่มโค้ดที่คุณต้องการเมื่อเลือก "Settings"
                  },
                ),
                // เพิ่มรายการอื่น ๆ ตามที่คุณต้องการ
              ],
            ),
          ),
        ],
      ),
    );
  }
}
