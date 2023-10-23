import 'package:flutter/material.dart';


class Admin_Chef extends StatefulWidget {
  const Admin_Chef({Key? key}) : super(key: key);

  @override
  State<Admin_Chef> createState() => _Admin_ChefState();
}

class _Admin_ChefState extends State<Admin_Chef> {
  late List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = [
      {"วันที่": "10/10/2023", "รายการ": "รายการ A"},
      {"วันที่": "11/10/2023", "รายการ": "รายการ B"},
      // ... เพิ่มข้อมูลเพิ่มเติมตามต้องการ
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length + 1, // เพิ่มจำนวนสำหรับ header
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header row
                return const Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("วันที่")),
                        Expanded(child: Text("รายการ")),
                      ],
                    ),
                    Divider(color: Colors.black),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(data[index - 1]["วันที่"] as String)),
                        Expanded(child: Text(data[index - 1]["รายการ"] as String)),
                      ],
                    ),
                    const Divider(color: Color.fromARGB(255, 255, 255, 255)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
  late List<Map<String, dynamic>> data;

 

   @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.5),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                columnSpacing: 24,  // เพิ่ม spacing สำหรับ column
                columns: [
                  const DataColumn(label: Text("   วันที่")),
                  const DataColumn(label: Text("รายการ")),
                ],
                rows: data.map((row) {
                  return DataRow(
                    color: MaterialStateProperty.resolveWith((states) => Colors.black12),  // กำหนดสีพื้นหลังสำหรับ row
                    cells: [
                      DataCell(Text(row["  วันที่"] as String)),
                      DataCell(Text(row["รายการ"] as String)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
