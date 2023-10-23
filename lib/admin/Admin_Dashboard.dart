import 'package:flutter/material.dart';


class Admin_Dashboard extends StatefulWidget {
  const Admin_Dashboard({Key? key}) : super(key: key);

  @override
  _Admin_DashboardState createState() => _Admin_DashboardState();
}

class _Admin_DashboardState extends State<Admin_Dashboard> {
  
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายงาน')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoCard(title: 'จำนวนบอร์ด', number: '150 รายการ'),
                InfoCard(title: 'ยอดเงินรวม', number: '10,458 บาท'),
              ],
            ),
            SizedBox(height: 20),
            StatisticsRow(title: 'แบบบอร์ด', active: '150', inactive: '141'),
            StatisticsRow(title: 'สินค้าทั้งหมด', active: '150', inactive: '130'),
            SizedBox(height: 20),
            BarGraph(),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String number;

  InfoCard({required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(number, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class StatisticsRow extends StatelessWidget {
  final String title;
  final String active;
  final String inactive;

  StatisticsRow({required this.title, required this.active, required this.inactive});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('เปิด $active'),
        Text('ปิด $inactive'),
      ],
    );
  }
}

class BarGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // สามารถใช้เพิ่มเติม flutter chart package ในการแสดงกราฟแท่ง
    // สำหรับตัวอย่างนี้ จะใช้ Container มาแทนกราฟแท่ง
    return Column(
      children: [
        Text('กราฟยอดขาย'),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // กราฟแท่งที่ 1
            Container(
              width: 50,
              height: 100,
              color: Colors.blue,
            ),
            // กราฟแท่งที่ 2
            Container(
              width: 50,
              height: 60,
              color: Colors.blue,
            ),
            // กราฟแท่งที่ 3
            Container(
              width: 50,
              height: 80,
              color: Colors.blue,
            ),
            // กราฟแท่งที่ 4
            Container(
              width: 50,
              height: 120,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}


