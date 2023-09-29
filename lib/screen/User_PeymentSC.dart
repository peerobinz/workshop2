import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/confirmPayment_dialog.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/MainManuSC.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // ลบ AppBar ทิ้ง
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50.0), // กำหนดระยะห่างด้านบน
            child: const Text(
              'ชำระเงิน',
              style: MyText.headline,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'ยอดชำระเงิน: 100 บาท',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
             showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ConfirmPaymentDialog();
                        },
                      );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF8525), // สีพื้นหลังของปุ่ม
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 67,
              ), // ปรับขนาดของปุ่ม+23ของปุ่มด่านล่าง
            ),
            child: const Text(
              'ยืนยันชำระเงิน',
              style: MyText.buttonpayment,
            ),
          ),
          const SizedBox(height: 20), // เพิ่มระยะห่างระหว่างปุ่ม
          ElevatedButton(
            onPressed: () {  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainMenu()),
          );
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xBBBBBB), // สีพื้นหลังของปุ่ม
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 70,
              ), // ปรับขนาดของปุ่ม
            ),
            child: const Text(
              'กลับหน้าหลัก',
              style: MyText.buttonpayment,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
