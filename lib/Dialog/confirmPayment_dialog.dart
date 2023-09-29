import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/User_Waiting.dart';

class ConfirmPaymentDialog extends StatelessWidget {
  const ConfirmPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Icon(Icons.receipt, size: 57, color: Colors.green),
          const SizedBox(height: 20),
          const Text('ต้องการชำระเงินหรือไม่', style: MyText.basic),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // เมื่อกดปุ่ม "ยืนยัน"
              // ทำสิ่งที่คุณต้องการเมื่อยืนยัน
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WaitForPaymentPage(),
                ),
              );
            },
            child: const Text('ยืนยัน'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
