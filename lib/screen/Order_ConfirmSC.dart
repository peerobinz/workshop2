import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2test/Dialog/confirmOder_dialog.dart';
import 'dart:convert';

import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/User_menu_Order.dart';

class OrderConfirm extends StatefulWidget {
  final List<dynamic> selectedMenuItems;

  const OrderConfirm({Key? key, required this.selectedMenuItems})
      : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  Future<String> fetchImageUrl(String itemName) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/menuitem/picture/$itemName'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['item_picture_url'] ?? '';
    } else {
      throw Exception('Failed to load image URL for $itemName');
    }
  }

  Map<String, int> getMenuItemCounts() {
    Map<String, int> menuItemCounts = {};
    for (var menuItem in widget.selectedMenuItems) {
      menuItemCounts[menuItem['item_name']] =
          (menuItemCounts[menuItem['item_name']] ?? 0) + 1;
    }
    return menuItemCounts;
  }

  Future<void> submitOrder() async {
    var data = jsonEncode(<String, dynamic>{
      'table_id': '7', // ต้องแทนที่ด้วย ID ของโต๊ะที่เกี่ยวข้อง
      'items': widget.selectedMenuItems.map((menuItem) {
        return {
          'item_name': menuItem['item_name'],
          'quantity': 1, // หรือจำนวนที่เกี่ยวข้อง
          // 'note_item': 'หมายเหตุเพิ่มเติมหากมี'
        };
      }).toList(),
    });

    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/order/create-and-add-items'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: data,
    );

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      print('New order created with ID: ${responseData['message']}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationDialog(
              selectedMenuItems: widget.selectedMenuItems);
        },
      );
    } else {
      print('Failed to create order: ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ผิดพลาด'),
            content: Text('ไม่สามารถบันทึกการสั่งซื้อของคุณได้'),
            actions: <Widget>[
              TextButton(
                child: Text('ปิด'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> menuItemCounts = getMenuItemCounts();
    int totalCount = menuItemCounts.values
        .fold(0, (previousValue, element) => previousValue + element);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'รายการอาหาร',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'รายการอาหาร',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'จำนวน $totalCount รายการ',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          color: AppColors.secondaryColor),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => User_menu_Order(
                                    selectedMenuItems: widget.selectedMenuItems,
                                  )),
                        );
                      },
                      child: const Text(
                        '+ เพิ่มรายการใหม่',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.button2,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItemCounts.keys.length,
              itemBuilder: (context, index) {
                String itemName = menuItemCounts.keys.elementAt(index);
                int itemCount = menuItemCounts[itemName]!;
                var menuItem = widget.selectedMenuItems.firstWhere(
                    (item) => item['item_name'] == itemName,
                    orElse: () => {});

                return FutureBuilder<String>(
                  future: fetchImageUrl(itemName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('ไม่พบข้อมูลรูปภาพ'));
                    }

                    var imageUrl = snapshot.data!;

                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                )
                              : Placeholder(),
                        ),
                        title: Text(itemName),
                        subtitle: Text('ราคา: ${menuItem['item_price']} บาท'),
                        trailing: Text('จำนวน: $itemCount'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            submitOrder();
          },
          child: Text(
            'ยืนยันการสั่งซื้อ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            primary: AppColors.primaryColor,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Icon(Icons.checklist,
            size: 57, color: Color.fromARGB(255, 174, 13, 13)),
        const SizedBox(height: 20),
        const Text('ทำรายการเสร็จสิ้น', style: MyText.basic),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
      ],
    ),
  );
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color errorColorGreen = Color(0xFF8DB5AD);
  static const Color button2 = Color(0xFF8DB5AD);
}
