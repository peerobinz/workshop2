import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class Admin_Order extends StatefulWidget {
  const Admin_Order({Key? key}) : super(key: key);

  @override
  _Admin_OrderState createState() => _Admin_OrderState();
}

class _Admin_OrderState extends State<Admin_Order> {
  String selectedDropdownValue1 = 'โต๊ะ 1';
  String selectedDropdownValue2 = 'สถานะ';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: selectedDropdownValue1,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropdownValue1 = newValue!;
                  });
                },
                items: <String>['โต๊ะ 1', 'ปุ่ม 2', 'ปุ่ม 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: AppColors.buttonEdit),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Spacer(),
          Row(
            // Add a Row widget
            children: [
              ElevatedButton(
                // Button on the left
                onPressed: () {
              
                // สร้าง QrCode จากข้อมูล
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            // ใช้ Expanded หรือ Flexible ถ้าจำเป็น
                            Expanded(
                              child: SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: QrImageView(
                                  data: "ช่องทางไปยังการสั่งอาหารโต๊ะ",
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                            const Text(
                                " Scan QR Code"),
                          ],
                        ),
                      ),
                    );
                  },
                );
                },
                child: Text(
                  'คิวอาร์โค้ด',
                  style: TextStyle(
                    color: AppColors.tabelGreen,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButton<String>(
                  value: selectedDropdownValue2,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownValue2 = newValue!;
                    });
                  },
                  items: <String>['สถานะ', 'ปุ่ม 2', 'ปุ่ม 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: AppColors.tabelGreen,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'ครั้งที่ 1',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Table(
              border: TableBorder.all(color: AppColors.errorColor),
              columnWidths: {
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(530),
                2: FixedColumnWidth(470),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Radio<bool>(
                          value: true,
                          groupValue: true,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        color: AppColors.tabelOn,
                        child: Text(
                          'รายการ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        color: AppColors.tabelOn,
                        child: Text(
                          'สถานะ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Radio<bool>(
                          value: true,
                          groupValue: true,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                        ),
                      ),
                    ),
                    TableCell(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'กระเพราไก่',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    )),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'กำลังปรุง',
                          style: TextStyle(
                            color: AppColors.errorColorOrenc,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppColors {
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color buttonEdit = Color(0xFFEEB75D);
}