import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/Admin_ConfrimTabel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Admin_Table extends StatefulWidget {
  const Admin_Table({Key? key}) : super(key: key);

  @override
  State<Admin_Table> createState() => _Admin_TableState();
}

class _Admin_TableState extends State<Admin_Table> {
  int tableCount = 9;
  List<bool> tableStatus = List.generate(9, (index) => false);

  @override
  void initState() {
    super.initState();
    fetchTables();
    fetchTableStatus(); // โหลดข้อมูลสถานะโต๊ะ
  }

  Future fetchTables() async {
    var url = Uri.parse('http://127.0.0.1:5000/table');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      setState(() {
        tableStatus =
            data.map((table) => table['is_occupied'] == 'ไม่ว่าง').toList();
        tableCount = tableStatus.length;
      });
    } else {
      // อาจแสดงข้อความเตือนหรือ log เพื่อการ debug
      throw Exception('Failed to load tables');
    }
  }

  Future addTable() async {
    var url = Uri.parse('http://127.0.0.1:5000/table/addtable');
    var response = await http.post(url);

    if (response.statusCode == 201) {
      await fetchTables(); // ตรวจสอบว่ามีการเรียก await ที่นี่
    } else {
      // อาจแสดงข้อความเตือนหรือ log เพื่อการ debug
      throw Exception('Failed to add table');
    }
  }

  Future deleteTable(int tableNumber) async {
    var url = Uri.parse('http://127.0.0.1:5000/table/deletetable');
    var response = await http.delete(url, body: {'id': tableNumber.toString()});

    if (response.statusCode == 200) {
      fetchTables(); // Reload table status
    } else {
      throw Exception('Failed to delete table');
    }
  }

  Future fetchTableStatus() async {
    var url = Uri.parse('http://127.0.0.1:5000/table/table_status');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      setState(() {
        // อัปเดต tableStatus ให้ตรงกับข้อมูลที่ได้รับจาก API
        tableStatus =
            data.map((table) => table['status_table'] == 'ไม่ว่าง').toList();
      });
    } else {
      throw Exception('Failed to load table status');
    }
  }

  void updateTableStatus(int index, bool isOccupied) {
    setState(() {
      tableStatus[index] = isOccupied;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.tabelGreen,
                width: 1,
              ),
              fixedSize: const Size(100, 10),
            ),
            child: const Text(
              "-- โต๊ะ",
              style: TextStyle(color: AppColors.tabelGreen),
            ),
            onPressed: () async {
              if (tableCount > 0) {
                // ถ้า ID โต๊ะใน backend เริ่มจาก 1, เราต้องลบ 1 ออกจาก tableCount ที่ส่งไป
                await deleteTable(tableCount - 1);
              } else {
                // แสดงข้อความแจ้งเตือนหรือทำการอื่น ๆ
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            crossAxisSpacing: 50.0,
            mainAxisSpacing: 50.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == tableCount) {
              return Container(
                width: 30,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: AppColors.errorColor, width: 2),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.add,
                        size: 50.0, color: AppColors.errorColor),
                    onPressed: () async {
                      await addTable();
                    },
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmTable(
                    index: index,
                    onUpdateStatus: updateTableStatus,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: tableStatus[index]
                      ? AppColors.tabelOn // สีเมื่อโต๊ะไม่ว่าง
                      : AppColors.tabelOff, // สีเมื่อโต๊ะว่าง
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    ' ${index + 1}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            );
          },
          itemCount: tableCount + 1,
        ),
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
