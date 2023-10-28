import 'package:flutter/material.dart';

class Admin_Queue extends StatefulWidget {
  const Admin_Queue({Key? key}) : super(key: key);

  @override
  State<Admin_Queue> createState() => _Admin_QueueState();
}

class _Admin_QueueState extends State<Admin_Queue> {
  String selectedDropdownValue = 'ทั้งหมด';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'รายการ',
              style: TextStyle(
                color: AppColors.tabelGreen,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Spacer(), // This adds space to push the dropdown to the right
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 500.0),
                  child: DropdownButton<String>(
                    value: selectedDropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'ทั้งหมด',
                      'สั่งอาหาร',
                      'เรียกพนักงาน',
                      'เช็คบิล'
                    ].map<DropdownMenuItem<String>>((String value) {
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
                  )),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(color: AppColors.errorColor),
              columnWidths: {
                0: FixedColumnWidth(70),
                1: FixedColumnWidth(1000),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        color: AppColors.tabelOn,
                        child: Text(
                          'โต๊ะ',
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
                          'รายการ',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1'),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'สั่งอาหาร ครั้งที 1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add your button's functionality here
                              },
                              child: Text(
                                'ดูรายละเอียด',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('3'),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'เรียกพนักงาน',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add your button's functionality here
                              },
                              child: Text(
                                'ลบ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('4'),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'เช็คบิล',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'ดูรายละเอียด',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
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
}