import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Admin_Order extends StatefulWidget {
  @override
  _Admin_OrderState createState() => _Admin_OrderState();
}

class _Admin_OrderState extends State<Admin_Order> {
  String selectedTable = '1';
  String selectedStatus = 'กำลังปรุง';
  List<Map<String, dynamic>> orders = [];

  Future<void> fetchOrdersByTable(int tableId) async {
    try {
      final response = await http.get(
          Uri.parse('http://127.0.0.1:5000/adminorders/showorders/$tableId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (mounted) {
          setState(() {
            orders = List<Map<String, dynamic>>.from(data.map((item) {
              return {
                "id": item['id'], // ต้องมี key นี้ใน item
                "table": item['table_id'].toString(),
                "item":
                    item['items'].map((i) => i['menu_item_name']).join(', '),
                "status": item['status'],
                "selected": false,
              };
            }));
          });
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> updateOrderItemStatus(int orderItemId, String newStatus) async {
    final url = Uri.parse(
        'http://127.0.0.1:5000/adminorders/update_orderitem_status/$orderItemId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'status': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        // อัปเดตสถานะใน local state หรือแสดง Snackbar ที่นี่
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order status updated successfully')),
        );
      } else {
        // แสดงข้อความผิดพลาดให้ผู้ใช้เห็น
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update order status')),
        );
      }
    } catch (e) {
      // แสดงข้อความผิดพลาดให้ผู้ใช้เห็น
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrdersByTable(int.parse(selectedTable));
  }

  void updateOrderStatus(String newStatus) {
    if (!mounted) return;

    setState(() {
      for (var order in orders) {
        if (order['selected']) {
          order['status'] = newStatus;
        }
      }
    });
  }

  Widget build(BuildContext context) {
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
                  icon:
                      Icon(Icons.arrow_drop_down, color: AppColors.tabelGreen),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedTable = newValue;
                      });
                      fetchOrdersByTable(int.parse(newValue));
                    }
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
                  icon:
                      Icon(Icons.arrow_drop_down, color: AppColors.tabelGreen),
                  onChanged: (String? newValue) {
                    if (selectedTable != null) {
                      fetchOrdersByTable(int.parse(selectedTable));
                    }

// ในการอัปเดตสถานะ
                    if (newValue != null) {
                      for (var order in orders) {
                        if (order['selected']) {
                          // ตรวจสอบว่า 'id' มีค่าและเป็น int
                          int? orderItemId =
                              int.tryParse(order['id'].toString());
                          if (orderItemId != null) {
                            updateOrderItemStatus(orderItemId, newValue);
                          } else {
                            print('Order ID is not valid.');
                          }
                        }
                      }
                      updateOrderStatus(newValue);
                    }
                  },
                  items: <String>['ทั้งหมด', 'กำลังปรุง', 'เสริฟแล้ว', 'ยกเลิก']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: getStatusColor(
                              value), // Set text color based on status
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
                  border:
                      Border.all(color: const Color.fromARGB(255, 184, 65, 26)),
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
                        DataColumn(
                            label: Text('เลือก', style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('โต๊ะ', style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('รายการ', style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('สถานะ', style: MyText.buttonpayment)),
                      ],
                      rows: orders.map<DataRow>((order) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Checkbox(
                                tristate: true,
                                value: order['selected'] ?? false,
                                onChanged: (bool? value) {
                                  if (!mounted) return;

                                  setState(() {
                                    order['selected'] = value ?? false;
                                  });

                                  if (value == true) {
                                    int? orderItemId =
                                        int.tryParse(order['id'].toString());
                                    if (orderItemId != null) {
                                      updateOrderItemStatus(
                                          orderItemId, selectedStatus);
                                    } else {
                                      // Handle the case where 'id' is not a valid integer
                                      print('Order ID is not valid.');
                                    }
                                  }
                                },
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.15,
                                child: Text(order['table'],
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.25,
                                child: Text(order['item'],
                                    textAlign: TextAlign.start),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: tableWidth * 0.25,
                                child: Text(order['status'],
                                    textAlign: TextAlign.start),
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

class AppColors {
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColor = Color(0xFFB00020);
}
