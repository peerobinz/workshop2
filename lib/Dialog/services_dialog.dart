import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';

class ServicesDialog extends StatelessWidget {
  const ServicesDialog({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Icon(
            Icons.people_sharp,
            size: 70,
            color: Color.fromARGB(255, 150, 21, 21),
          ),
          Text(
            'คุณต้องการเรียกพนักงานหรือไม่',
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
                backgroundColor: MaterialStateProperty.all(const Color(0xFFBBBBBB)), 
                textStyle: MaterialStateProperty.all(MyText.button),
                fixedSize: MaterialStateProperty.all(const Size(130, 40)),
              ),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF0E4E89)), 
                textStyle: MaterialStateProperty.all(MyText.button),
                fixedSize: MaterialStateProperty.all(const Size(130, 40)),
                
              ),
              child: const Text('ยืนยัน'),
            ),
          ],
        ),
      ],
    );
  }
}
