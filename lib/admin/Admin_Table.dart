import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/Admin_ConfrimTabel.dart';

class Admin_Table extends StatefulWidget {
  const Admin_Table({Key? key}) : super(key: key);

  @override
  State<Admin_Table> createState() => _Admin_TableState();
}

class _Admin_TableState extends State<Admin_Table> {
  int tableCount = 9;
  List<bool> tableStatus = List.generate(9, (index) => false);

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
        elevation: 0, // ลบเงาของ AppBar
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: AppColors.tabelGreen, // กำหนดสีของกรอบ
                width: 1, // ความหนาของกรอบ
              ),
              fixedSize: const Size(100, 10),
            ),
            child: const Text(
              "-- โต๊ะ",
              style:
                  TextStyle(color: AppColors.tabelGreen), // กำหนดสีของข้อความ
            ),
            onPressed: () {
              if (tableCount > 0) {
                setState(() {
                  tableCount--;
                  tableStatus.removeLast();
                });
              } else {
                // หากไม่มีโต๊ะที่จะลบ, คุณสามารถแสดงข้อความแจ้งเตือนหรือทำการอื่น ๆ
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
            childAspectRatio: 1.5,//ปรับขนาดโต๊ะ
            crossAxisSpacing: 50.0,
            mainAxisSpacing: 50.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == tableCount) {
              return Container(
                width: 30, // กำหนดความกว้าง
                height: 70, // กำหนดความสูง
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), // เพิ่มความโค้ง
                  border: Border.all(color: AppColors.errorColor, width: 2),
                ),
                child: Align(
                  alignment:
                      Alignment.center, // กำหนดตำแหน่งให้อยู่ตรงกลาง Container
                  child: IconButton(
                    icon: const Icon(Icons.add,
                        size: 50.0, color: AppColors.errorColor),
                    onPressed: () {
                      setState(() {
                        tableCount++;
                        tableStatus.add(false);
                      });
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
                      ? AppColors.tabelOn
                      : AppColors.tabelOff,
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
