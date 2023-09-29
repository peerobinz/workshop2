import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';

class ServicesDialog extends StatelessWidget {
  const ServicesDialog({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'เรียกพนักงาน',
        style: MyText.headline, // ใช้ MyText.headline TextStyle จาก MyText
      ),
      content: SizedBox.shrink(),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิด Dialog
          },
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(MyText.buttoncomfirm), // ใช้ MyText.buttoncomfirm TextStyle จาก MyText
          ),
          child: const Text('ยืนยัน'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิด Dialog
          },
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(MyText.button), // ใช้ MyText.button TextStyle จาก MyText
          ),
          child: const Text('ยกเลิก'),
        ),
      ],
    );
  }
}
