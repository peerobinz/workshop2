import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';

class Admin_Queue extends StatefulWidget {
  const Admin_Queue({Key? key}) : super(key: key);

  @override
  State<Admin_Queue> createState() => _Admin_QueueState();
}

class _Admin_QueueState extends State<Admin_Queue> {
  String selectedDropdownValue = 'ทั้งหมด';

  final List<Map<String, dynamic>> orders = [
    {'table': '1', 'queue': 'สั่งอาหาร', 'receipt': 'View'},
    {
      'table': '2',
      'queue': 'เรียกพนักงาน',
      'receipt': 'View'
    }, // แถวข้อมูลใหม่ที่ถูกเพิ่ม
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
            const Text(
              'รายการ',
              style: TextStyle(
                color: AppColors.tabelGreen,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10),
            DropdownButton<String>(
              value: selectedDropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDropdownValue = newValue!;
                });
              },
              items: <String>['ทั้งหมด', 'สั่งอาหาร', 'เรียกพนักงาน', 'เช็คบิล']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.tabelGreen,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double tableWidth = constraints.maxWidth * 0.93;
            double tableHeight = constraints.maxHeight * 0.7;

            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: tableWidth,
                height: tableHeight,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 184, 65, 26)),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor:
                        Colors.transparent, // ทำให้ divider สีเดียวกับพื้นหลัง
                    dataTableTheme: DataTableThemeData(
                      headingRowColor: MaterialStateProperty.all(
                          const Color.fromARGB(137, 237, 99, 53)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text('           โต๊ะ',
                                style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('    รายการ ',
                                style: MyText.buttonpayment)),
                        DataColumn(label: Text('  ')),
                      ],
                      rows: orders.map<DataRow>((order) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width:
                                    tableWidth * 0.15, // ปรับขนาดตามความจำเป็น
                                child: Text(order['table'],
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width:
                                    tableWidth * 0.25, // ปรับขนาดตามความจำเป็น
                                child: Text(order['queue'],
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 200.0, // ปรับความกว้างตามความจำเป็น
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .end, // จัดตำแหน่งให้ปุ่มอยู่ด้านขวา
                                  children: [
                                    // ปุ่มดูรายละเอียด
                                   
                                    const SizedBox(
                                        width: 10), // ระยะห่างระหว่างปุ่ม
                                    // ปุ่มลบรายการ
                                    SizedBox(
                                      width: 90.0,
                                      height: 40.0,
                                      child: TextButton(
                                        onPressed: () {
                                          // การดำเนินการเมื่อปุ่มถูกกด
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              Colors.red, // ตั้งค่าสีของปุ่มลบ
                                        ),
                                        child: const Text(
                                          'ลบรายการ',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
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
}
