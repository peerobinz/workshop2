import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';

class Admin_Order extends StatefulWidget {
  @override
  _Admin_OrderState createState() => _Admin_OrderState();
}

class _Admin_OrderState extends State<Admin_Order> {
  String selectedTable = '1';
  String selectedStatus = 'กำลังปรุง';

  // Dummy data for the table
  List<Map<String, dynamic>> orders = [
    {"table": "1", "item": "อาหาร A", "status": "กำลังปรุง"},
    {"table": "2", "item": "อาหาร B", "status": "สริฟแล้ว"},
    {"table": "3", "item": "อาหาร C", "status": "ยกเลิก"},
    // Add more orders here
  ];

  // Function to filter orders by status
  List<Map<String, dynamic>> getFilteredOrders() {
    if (selectedStatus == 'ทั้งหมด') {
      return orders;
    } else {
      return orders.where((order) => order['status'] == selectedStatus).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Call this function to get filtered list based on the selected status
    List<Map<String, dynamic>> filteredOrders = getFilteredOrders();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dropdown for Tables
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.tabelGreen),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTable,
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.tabelGreen),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTable = newValue!;
                      // TODO: Update content based on selected table
                    });
                  },
                  items: <String>['1', '2', '3', '4', '5']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('โต๊ะ $value'),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
              ),
            ),
            // Dropdown for Status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.tabelGreen),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedStatus,
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.tabelGreen),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                      // Update the filtered list when status changes
                      filteredOrders = getFilteredOrders();
                    });
                  },
                  items: <String>['ทั้งหมด', 'กำลังปรุง', 'สริฟแล้ว', 'ยกเลิก']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: getStatusColor(value), // Set text color based on status
                        ),
                      ),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                ),
              ),
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
                  border: Border.all(color: const Color.fromARGB(255, 184, 65, 26)),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    dataTableTheme: DataTableThemeData(
                      headingRowColor: MaterialStateProperty.all(
                          const Color.fromARGB(137, 237, 99, 53)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 38.0,
                      columns: const [
                        DataColumn(label: Text('โต๊ะ', style: MyText.buttonpayment)),
                        DataColumn(label: Text('รายการ', style: MyText.buttonpayment)),
                        DataColumn(label: Text('สถานะ', style: MyText.buttonpayment)),
                      ],
                      rows: filteredOrders.map<DataRow>((order) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.15,
                                child: Text(order['table'], textAlign: TextAlign.center),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.25,
                                child: Text(order['item'], textAlign: TextAlign.start),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.25,
                                child: Text(order['status'], textAlign: TextAlign.start),
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'กำลังปรุง':
        return Colors.yellow.shade900;
      case 'สริฟแล้ว':
        return Colors.green;
      case 'ยกเลิก':
        return Colors.red;
      default:
        return Colors.black; // Default color if status doesn't match
    }
  }
}

class AppColors {
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColor = Color(0xFFB00020);
}
