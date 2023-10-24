import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';



class Admin_CancelEdit extends StatelessWidget {
  const Admin_CancelEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Icon(
            Icons.close,
            size: 100,
            color: Color.fromARGB(255, 150, 21, 21),
          ),
          Text(
            'คุณต้องการยกเลิกหรือไม่',
            style: MyText.basic,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // คืนค่า true
              
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
                 Navigator.of(context).pop(false); // ปิด Dialog
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
