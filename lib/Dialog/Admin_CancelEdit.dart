import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/admin/Admin_Stock.dart';


class Admin_CancelEdit extends StatelessWidget {
  const Admin_CancelEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Icon(
            Icons.edit_calendar_outlined,
            size: 100,
            color: Color.fromARGB(255, 150, 21, 21),
          ),
          Text(
            'คุณต้องการแก้ไขต่อหรือไม่',
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Admin_Stock(),
                  ),
                );
              
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
                 Navigator.of(context).pop(); // ปิด Dialog
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
