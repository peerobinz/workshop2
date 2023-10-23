import 'package:flutter/material.dart';

class Admin_checkbill extends StatefulWidget {
  const Admin_checkbill({Key? key}) : super(key: key);

  @override
  State<Admin_checkbill> createState() => _Admin_checkbillState();
}

class _Admin_checkbillState extends State<Admin_checkbill> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.black, // ปรับสีเส้นของตาราง
            ),
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.orange), // สีพื้นหลังของ header
                columnSpacing: width * 0.02,
                columns: const [
                  DataColumn(
                    label: Text('ลำดับ'),
                  ),
                  DataColumn(
                    label: Text('วันที่'),
                  ),
                  DataColumn(
                    label: Text('รหัสสินค้า'),
                  ),
                  DataColumn(
                    label: Text('จำนวนเงิน'),
                  ),
                  DataColumn(
                    label: Text('การชำระเงิน'),
                  ),
                  DataColumn(
                    label: Text('การจัดการ'),
                  ),
                ],
                rows: [
                  DataRow(
                    color: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)), // ปรับสีพื้นหลังของแถว
                    cells: [
                      const DataCell(Text('1', )),
                      const DataCell(Text('10/04/2023', )),
                      const DataCell(Text('0000000001', )),
                      const DataCell(Text('650.00 บาท',)),
                      const DataCell(Text('ชำระเเล้ว', )),
                      DataCell(Row(
                        children: [Icon(Icons.edit, size: width * 0.02, color: const Color.fromARGB(255, 0, 0, 0)), Icon(Icons.delete, size: width * 0.02, color: const Color.fromARGB(255, 0, 0, 0))],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
