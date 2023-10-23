import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/Admin_ConfrimDelete.dart';
import 'package:workshop2test/Text/my_text.dart';
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
                  height: 40, // ปรับขนาดตามที่ต้องการ
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหารายการสินค้า...',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.tabelGreen, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25.0),
              ),
              icon: const Icon(
                Icons.add,
                color: AppColors.tabelGreen,
                size: 30,
              ),
              label: const Text(
                'เพิ่มรายการ',
                style: TextStyle(color: AppColors.tabelGreen, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double tableWidth = constraints.maxWidth * 0.9;
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
                            label: SizedBox(
                                width: 200.0,
                                child: Text('รายการ',
                                    style: MyText.buttonpayment))),
                        DataColumn(
                            label: SizedBox(
                                width: 200.0,
                                child: Text(
                                  'ราคา',
                                  style: MyText.buttonpayment,
                                ))),
                        DataColumn(
                            label: SizedBox(
                                width: 100.0,
                                child: Text('สถานะ',
                                    style: MyText.buttonpayment))),
                        DataColumn(
                            label: SizedBox(
                                width: 100.0,
                                child: Text('', style: MyText.buttonpayment))),
                      ],
                      rows: items.map((item) {
                        return DataRow(cells: [
                          DataCell(Text(item['name'])),
                          DataCell(Text(item['price'])),
                          DataCell(DropdownButtonHideUnderline(
                            child: Container(
                              width: 100.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: AppColors.tabelGreen,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: DropdownButton<String>(
                                value: item['status'],
                                items: const [
                                  DropdownMenuItem(
                                    value: 'มี',
                                    child: Text('มี',
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'หมด',
                                    child: Text('หมด',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    item['status'] = value;
                                  });
                                },
                                hint: Text(
                                  item['status'],
                                  style: const TextStyle(
                                      color: Colors.white), // ตั้งค่าสีขาว
                                ),
                                selectedItemBuilder: (BuildContext context) {
                                  return [
                                    const Text('มี',
                                        style: TextStyle(color: Colors.white)),
                                    const Text('หมด',
                                        style: TextStyle(color: Colors.white)),
                                  ];
                                },
                                isExpanded: true,
                              ),
                            ),
                          )),
                          DataCell(Row(children: [
                            SizedBox(
                              width: 100.0, // กำหนดความกว้างของปุ่ม
                              height: 30.0, // กำหนดความสูงของปุ่ม
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Admin_StockEdit(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.buttonEdit),
                                child: const Text('แก้ไข'),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            SizedBox(
                              width: 70.0, // กำหนดความกว้างของปุ่ม
                              height: 70.0, // กำหนดความสูงของปุ่ม
                              child: IconButton(
                                icon: const Icon(Icons.delete_outline_outlined),
                                iconSize: 40,
                                color: const Color.fromARGB(255, 123, 120, 120),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const Admin_ConfirmDelete();
                                    },
                                  );
                                },
                              ),
                            ),
                          ])),
                        ]);
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
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color tabelOff = Color(0xFF8DB5AD);
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color buttonEdit = Color(0xFFEEB75D);
  static const Color colum = Color(0xFFED6335);
}
