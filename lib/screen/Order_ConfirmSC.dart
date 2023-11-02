import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/User_StatusSC.dart';
import 'package:workshop2test/screen/User_menu_Order.dart';

class OrderConfirm extends StatefulWidget {
  final List<dynamic> selectedMenuItems; // Change to dynamic

  const OrderConfirm({Key? key, required this.selectedMenuItems})
      : super(key: key); // Change the constructor

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  Future<bool> placeOrder(List<dynamic> selectedMenuItems) async {
    Uri url = Uri.parse('http://127.0.0.1:5000/OderConfirm/PlaceOrder');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'table_id': 'Your_Table_ID',
          'items': selectedMenuItems
              .map((menuItem) => {
                    'menu_item_id':
                        menuItem['id'], // Adjust field names as necessary
                    'quantity':
                        menuItem['quantity'], // Adjust field names as necessary
                  })
              .toList(),
        }),
      );

      if (response.statusCode == 201) {
        return true;
      }
      print('Failed to place order. Status Code: ${response.statusCode}');
      return false;
    } catch (e) {
      print('Error placing order: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          decoration: const BoxDecoration(
            color: Color(0xFFFBFCFC),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(101, 34, 0, 0),
                    child: Text(
                      'รายการอาหาร',
                      style: MyText.headline
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 68, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align children to the start/left
                      children: [
                        Text(
                          'รายการอาหาร',
                          style: MyText.buttoncomfirm
                              .copyWith(color: AppColors.secondaryColor),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Separate the text and the button
                          children: [
                            Text(
                              'จำนวนรายการ: ${widget.selectedMenuItems.length}',
                              style: MyText.subheading
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => User_menu_Order()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.button2,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  '+ เพิ่มรายการใหม่',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedMenuItems.length,
                      itemBuilder: (context, index) {
                        final menuItem = widget.selectedMenuItems[index];
                        return ListTile(
                          title: Text(menuItem[
                              'name']), // Adjust field names as necessary
                          subtitle: Text(menuItem[
                              'category']), // Adjust field names as necessary
                          leading: Image.network(menuItem[
                              'imageUrl']), // Adjust field names as necessary
                          trailing: Text(
                              'จำนวน: ${menuItem['quantity']}'), // Adjust field names as necessary
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 50,
                left: 60,
                right: 60,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool result = await placeOrder(widget.selectedMenuItems);
                      if (result) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserStatus(
                              selectedMenuItems: widget
                                  .selectedMenuItems, // Change to selectedMenuItems
                            ),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Failed to place the order. Please try again.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 60),
                      backgroundColor: AppColors.primaryColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'ยืนยันรายการ',
                      style: MyText.buttoncomfirm,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color button2 = Color(0xFF8DB5AD);
  // ... add more colors as needed
}
