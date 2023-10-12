import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('แนวตั้ง 6 ปุ่มติดต่อกัน'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มแรก
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 1'),
          ),
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มที่สอง
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 2'),
          ),
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มที่สาม
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 3'),
          ),
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มที่สี่
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 4'),
          ),
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มที่ห้า
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 5'),
          ),
          ElevatedButton(
            onPressed: () {
              // ตรวจสอบการกดปุ่มที่หก
              // ใส่โค้ดที่คุณต้องการในนี่
            },
            child: Text('ปุ่ม 6'),
          ),
        ],
      ),
    );
  }
}
