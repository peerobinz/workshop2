import 'package:http/http.dart' as http;
import 'dart:convert';
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

  Future<void> updateTableStatus(int tableId, bool isOccupied) async {
    final status = isOccupied
        ? 'ไม่ว่าง'
        : 'ว่าง'; // ใช้ค่าภาษาไทยที่ตรงกับ TableStatusEnum
    final response = await http.put(
      Uri.parse('http://127.0.0.1:5000/table/update_status_table/$tableId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'is_occupied': status, // ตรงกับ key ที่ backend รับ
      }),
    );
    if (response.statusCode == 200) {
      // Handle success
      print('Status updated to $status');
    } else {
      // Handle error
      print('Failed to update status: ${response.body}');
    }
  }

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
              onPressed: () async {
                await updateTableStatus(index + 1,
                    false); // เรียกใช้ API เพื่ออัปเดตสถานะเป็น 'ว่าง'
                onUpdateStatus(index, false); // อัปเดตสถานะใน UI
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
              onPressed: () async {
                await updateTableStatus(index + 1,
                    true); // เรียกใช้ API เพื่ออัปเดตสถานะเป็น 'ไม่ว่าง'
                onUpdateStatus(index, true); // อัปเดตสถานะใน UI
                Navigator.of(context).pop(); // ปิด dialog ปัจจุบัน

                // สร้าง QrCode จากข้อมูล
                final qrData = "qr_code ""${index + 1}";
                final qrCode = QrCode.fromData(
                    data: qrData, errorCorrectLevel: QrErrorCorrectLevel.L);

                // ignore: use_build_context_synchronously
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
                                      "https://www.google.co.th/?hl=th/${index + 1}",
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
