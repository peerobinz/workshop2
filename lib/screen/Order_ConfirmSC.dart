import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class OrderConfirm extends StatefulWidget {
//   final List<dynamic> selectedMenuItems; // Change to dynamic

//   const OrderConfirm({Key? key, required this.selectedMenuItems})
//       : super(key: key); // Change the constructor

//   @override
//   State<OrderConfirm> createState() => _OrderConfirmState();
// }

// class _OrderConfirmState extends State<OrderConfirm> {
//   Future<bool> placeOrder(List<dynamic> selectedMenuItems) async {
//     Uri url = Uri.parse('http://127.0.0.1:5000/OderConfirm/PlaceOrder');

//     try {
//       var response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'table_id': 'Your_Table_ID',
//           'items': selectedMenuItems
//               .map((menuItem) => {
//                     'menu_item_id':
//                         menuItem['id'], // Adjust field names as necessary
//                     'quantity':
//                         menuItem['quantity'], // Adjust field names as necessary
//                   })
//               .toList(),
//         }),
//       );

//       if (response.statusCode == 201) {
//         return true;
//       }
//       print('Failed to place order. Status Code: ${response.statusCode}');
//       return false;
//     } catch (e) {
//       print('Error placing order: $e');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 390,
//           height: 844,
//           decoration: const BoxDecoration(
//             color: Color(0xFFFBFCFC),
//             boxShadow: [
//               BoxShadow(
//                 color: Color.fromRGBO(0, 0, 0, 0.25),
//                 blurRadius: 4,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(101, 34, 0, 0),
//                     child: Text(
//                       'รายการอาหาร',
//                       style: MyText.headline
//                           .copyWith(color: AppColors.secondaryColor),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(15, 68, 0, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment
//                           .start, // Align children to the start/left
//                       children: [
//                         Text(
//                           'รายการอาหาร',
//                           style: MyText.buttoncomfirm
//                               .copyWith(color: AppColors.secondaryColor),
//                           textAlign: TextAlign.left,
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment
//                               .spaceBetween, // Separate the text and the button
//                           children: [
//                             Text(
//                               'จำนวนรายการ: ${widget.selectedMenuItems.length}',
//                               style: MyText.subheading
//                                   .copyWith(color: AppColors.secondaryColor),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => User_menu_Order()),
//                                 );
//                               },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//             vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//           color: AppColors.button2,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: const Text(
//           '+ เพิ่มรายการใหม่',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     )
//   ],
// ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: widget.selectedMenuItems.length,
//                       itemBuilder: (context, index) {
//                         final menuItem = widget.selectedMenuItems[index];
//                         return ListTile(
//                           title: Text(menuItem[
//                               'item_name']), // Adjust field names as necessary
//                           leading: Image.network(menuItem[
//                               'item_picture_url']), // Adjust field names as necessary
//                           trailing: Text(
//                               'จำนวน: ${menuItem['quantity']}'), // Adjust field names as necessary
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 bottom: 50,
//                 left: 60,
//                 right: 60,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       bool result = await placeOrder(widget.selectedMenuItems);
//                       if (result) {
//                         // ignore: use_build_context_synchronously
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => UserStatus(
//                               selectedMenuItems: widget
//                                   .selectedMenuItems, // Change to selectedMenuItems
//                             ),
//                           ),
//                         );
//                       } else {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Error'),
//                               content: const Text(
//                                   'Failed to place the order. Please try again.'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   child: const Text('Close'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(350, 60),
//                       backgroundColor: AppColors.primaryColor,
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: const Text(
//                       'ยืนยันรายการ',
//                       style: MyText.buttoncomfirm,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AppColors {
//   static const Color primaryColor = Color(0xFF0E4E89);
//   static const Color secondaryColor = Color(0xFF026D81);
//   static const Color button2 = Color(0xFF8DB5AD);
//   // ... add more colors as needed
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:workshop2test/Dialog/confirmOder_dialog.dart';

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
                        // Add action for the button
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  selectedMenuItems: widget.selectedMenuItems,
                );
              },
            );
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

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color button2 = Color(0xFF8DB5AD);
  // ... add more colors as needed
}
