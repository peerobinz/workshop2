import 'package:flutter/material.dart';
import 'package:workshop2test/screen/MainManuSC.dart';

class WaitForPaymentPage extends StatelessWidget {
  const WaitForPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.receipt_long_outlined, // ไอคอนใบเสร็จ
                  size: 300, // ขนาดของไอคอน
                  color: Color.fromARGB(255, 158, 19, 19), // สีของไอคอน
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(), // แสดงรูปแห่งการโหลด
                SizedBox(height: 10),
                Text(
                  'กรุณารอสักครู่...',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color.fromARGB(255, 158, 19, 19),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40, // ตำแหน่งจากด้านบน
            right: 20, // ตำแหน่งจากด้านขวา
            child: IconButton(
              icon: const Icon(
                Icons.close, // ไอคอน x
                size: 50, // ขนาดของไอคอน
                color: Color.fromARGB(255, 158, 19, 19), // สีของไอคอน
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
