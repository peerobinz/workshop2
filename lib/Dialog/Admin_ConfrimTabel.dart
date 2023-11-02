import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr/qr.dart';

class ConfirmTable extends StatelessWidget {
  final int index;
  final Function(int, bool) onUpdateStatus;

  ConfirmTable({
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
                Navigator.of(context).pop(); // ปิด dialog ปัจจุบัน

                // สร้าง QrCode จากข้อมูล
                final qrData = "ช่องทางไปยังการสั่งอาหารโต๊ะ${index + 1}";
                final qrCode = QrCode.fromData(
                    data: qrData, errorCorrectLevel: QrErrorCorrectLevel.L);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            // ใช้ Expanded หรือ Flexible ถ้าจำเป็น
                            Flexible(
                              child: SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: QrImageView(
                                  data:
                                      "ช่องทางไปยังการสั่งอาหารโต๊ะ${index + 1}",
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                            Text(
                                "Scan this QR Code to open table ${index + 1}"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF0E4E89)),
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
