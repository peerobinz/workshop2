import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/admin/Admin_Stock.dart';


class Admin_ConfirmEdit extends StatelessWidget {
  const Admin_ConfirmEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Icon(
            Icons.supervised_user_circle_outlined,
            size: 100,
            color: Color.fromARGB(255, 150, 21, 21),
          ),
          Text(
            'ยืนยันการแก้ไขข้อมูล',
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
                Navigator.of(context).pop(); 
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
                Navigator.of(context).pop(true); // คืนค่า true
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
