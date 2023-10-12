import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/User_Waiting.dart';

class ConfirmPaymentDialog extends StatelessWidget {
  const ConfirmPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Icon(
            Icons.receipt_long_sharp,
            size: 70,
            color: Color.fromARGB(255, 150, 21, 21),
          ),
          Text(
            'คุณต้องการชำระเงินหรือไม่',
            style: MyText.button,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFBBBBBB)),
                textStyle: MaterialStateProperty.all(MyText.button),
                fixedSize: MaterialStateProperty.all(const Size(100, 40)),
              ),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => WaitForPaymentPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF0E4E89)),
                textStyle: MaterialStateProperty.all(MyText.button),
                fixedSize: MaterialStateProperty.all(const Size(100, 40)),
              ),
              child: const Text('ยืนยัน'),
            ),
          ],
        ),
      ],
    );
  }
}
