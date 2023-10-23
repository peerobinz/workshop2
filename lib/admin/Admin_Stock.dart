import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/Admin_ConfrimDelete.dart';
import 'package:workshop2test/admin/Admin_StockAdd.dart';
import 'package:workshop2test/admin/Admin_StockEdit.dart';

class Admin_Stock extends StatefulWidget {
  const Admin_Stock({super.key});

  @override
  State<Admin_Stock> createState() => _Admin_StockState();
}

class _Admin_StockState extends State<Admin_Stock> {
  List<Map<String, dynamic>> items = [
    {'name': 'สินค้า A', 'price': '100', 'status': 'มี'},
    {'name': 'สินค้า B', 'price': '200', 'status': 'หมด'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter, // ทำให้ชิดกับขอบล่าง
                child: SizedBox(
                  width: 900,
                  height: 50, // ปรับขนาดตามที่ต้องการ
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหารายการสินค้า...',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Admin_StockAdd()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('เพิ่มรายการ'),
            ),
          ],
        ),
      ),
      body: DataTable(
        columns: const [
          DataColumn(label: Text('รายการ')),
          DataColumn(label: Text('ราคา')),
          DataColumn(label: Text('สถานะ')),
          DataColumn(label: Text('    ')),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            DataCell(Text(item['name'])),
            DataCell(Text(item['price'])),
            DataCell(DropdownButton(
              value: item['status'],
              items: const [
                DropdownMenuItem(child: Text('มี'), value: 'มี'),
                DropdownMenuItem(child: Text('หมด'), value: 'หมด'),
              ],
              onChanged: (value) {
                setState(() {
                  item['status'] = value;
                });
              },
            )),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Admin_StockEdit()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Admin_ConfirmDelete();
                      },
                    );
                  },
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color tabelOff = Color(0xFF8DB5AD);
  static const Color tabelGreen = Color(0xFF8DB5AD);
}
