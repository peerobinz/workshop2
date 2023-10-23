import 'package:flutter/material.dart';

class ConfrimTabel extends StatelessWidget {
  final int index;
  final Function(int, bool) onUpdateStatus;

  ConfrimTabel({
    required this.index,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15), // ระบุระยะขอบโค้งที่ต้องการ
  ),
      title: Column(
        children: [
          Image.asset(
            'assets/icons8-table-60.png',
            width: 70,
            height: 70,
            color: const Color.fromARGB(255, 150, 21, 21),
            colorBlendMode:
                BlendMode.srcIn, // ใช้สำหรับการกำหนดสีให้รูปภาพที่เป็นขาวดำ
          ),
          Text(
            'โต๊ะ ${index + 1}',
            style: const TextStyle(
              // คุณสามารถปรับเปลี่ยน style ในส่วนนี้เพื่อตรงกับต้องการ
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('ยืนยันการเปิดโต๊ะ'),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                onUpdateStatus(index, false);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFBBBBBB)),
                // แก้ textStyle เป็น style ของคุณเองหรือลบออก
                textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
                fixedSize: MaterialStateProperty.all(const Size(130, 40)),
              ),
              child: const Text('ยกเลิก'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                onUpdateStatus(index, true);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF0E4E89)),
                // แก้ textStyle เป็น style ของคุณเองหรือลบออก
                textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
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
