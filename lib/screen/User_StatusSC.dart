// import 'package:flutter/material.dart';
// import 'package:workshop2test/Dialog/services_dialog.dart';
// import 'package:workshop2test/Text/my_text.dart';
// import 'package:workshop2test/screen/User_PeymentSC.dart';
// import 'package:workshop2test/screen/User_menu_Order.dart';

// class UserStatus extends StatefulWidget {
//   late final List<dynamic> selectedMenuItems;
//   @override
//   State<UserStatus> createState() => _UserStatusState();
// }

// class _UserStatusState extends State<UserStatus> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             expandedHeight: 50.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: const FlexibleSpaceBar(
//               title: Text(
//                 'สถานะ',
//                 style: TextStyle(
//                   color: AppColors.secondaryColor,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.receipt,
//                   color: AppColors.secondaryColor,
//                   size: 40.0,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentPage(
//                           selectedMenuItems: widget.selectedMenuItems),
//                     ),
//                   );
//                 },
//               ),
//             ],
//             leading: IconButton(
//               icon: const Icon(
//                 Icons.notification_add,
//                 color: AppColors.secondaryColor,
//                 size: 40.0,
//               ),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return const ServicesDialog();
//                   },
//                 );
//               },
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 final menuItem = widget.selectedMenuItems[index];
//                 return ListTile(
//                   title: Text(menuItem['name']),
//                   subtitle: Text(menuItem['category']),
//                   leading: Image.network(menuItem['imageUrl']),
//                   trailing: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('จำนวน: ${menuItem['quantity']}'),
//                       const Text(
//                         'สถานะ: กำลังปรุง',
//                         style: TextStyle(
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               childCount: widget.selectedMenuItems.length,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => User_menu_Order(
//                       selectedMenuItems: [],
//                     )),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primaryColor,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           fixedSize: const Size(350, 60),
//         ),
//         child: const Text(
//           'สั่งอาหาร',
//           style: MyText.buttoncomfirm,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// class AppColors {
//   static const Color primaryColor = Color(0xFF0E4E89);
//   static const Color secondaryColor = Color(0xFF026D81);
//   static const Color errorColor = Color(0xFFB00020);
//   // ... add more colors as needed
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workshop2test/Dialog/services_dialog.dart';
import 'package:workshop2test/screen/User_PeymentSC.dart';

class OrderStatusScreen extends StatefulWidget {
  final num orderId;

  const OrderStatusScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
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

  Future<List<MenuItemStatus>> fetchOrderStatus() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/status/orderstatus/${widget.orderId}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => MenuItemStatus.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load order status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.notification_add), iconSize: 45,
            color: AppColors.titlebar, // สามารถเปลี่ยนเป็นไอคอนที่คุณต้องการ
            onPressed: () {
              showDialog(
                context: context, // ส่ง BuildContext ของคุณ
                builder: (BuildContext context) {
                  return ServicesDialog(); // เรียกใช้ Dialog ที่คุณสร้างไว้
                },
              );
            },
          ),
          title: Text(
            'สถานะ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.titlebar,
                fontSize: 30),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.receipt_long), iconSize: 45,
              color: AppColors.titlebar, // สามารถเปลี่ยนเป็นไอคอนที่คุณต้องการ
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentPage(
                            selectedMenuItems: [],
                          )), // แทนที่ NewScreen ด้วยหน้าจอที่คุณต้องการไป
                );
              },
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: FutureBuilder<List<MenuItemStatus>>(
            future: fetchOrderStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return Text("No data found");
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  MenuItemStatus menuItemStatus = snapshot.data![index];
                  return FutureBuilder<String>(
                    future: fetchImageUrl(menuItemStatus.itemName),
                    builder: (context, snapshot) {
                      var imageUrl = snapshot.data ?? '';
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(8.0),
                        color: AppColors.card, // สีของการ์ด
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
                          title: Text(menuItemStatus.itemName),
                          subtitle: Text('หมายเหตุ: ${menuItemStatus.note}'),
                          trailing: Text(
                            menuItemStatus.status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors
                                      .statusColors[menuItemStatus.status] ??
                                  Colors
                                      .black, // เลือกสีตามสถานะหรือใช้สีดำเป็นค่าเริ่มต้น// สีของข้อความสถานะ
                              fontSize: 18, // ขนาดของตัวหนังสือ
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 70, // กำหนดให้ปุ่มเต็มความกว้าง
              height: 60.0, // กำหนดความสูงของปุ่ม
              child: TextButton(
                onPressed: () {
                  // ไม่มีการกระทำใดๆ เมื่อกด
                },
                child: Text(
                  'สั่งอาหาร',
                  style: TextStyle(fontSize: 25),
                ),
                style: TextButton.styleFrom(
                  backgroundColor:
                      AppColors.botton, // เปลี่ยนเป็นสีที่คุณต้องการ
                  primary: Colors.white, // สีของข้อความ
                  padding: EdgeInsets.symmetric(vertical: 15.0), // ขนาด padding
                ),
              ),
            ),
          ),
        ));
  }
}

class MenuItemStatus {
  final num orderId;
  final String itemName;
  final String note;
  final String status;

  MenuItemStatus({
    required this.orderId,
    required this.itemName,
    required this.note,
    required this.status,
  });

  factory MenuItemStatus.fromJson(Map<String, dynamic> json) {
    return MenuItemStatus(
      orderId: json['order_id'] as num,
      itemName: json['menu_item_name'] as String,
      note: json['note_item'] ??
          'ไม่มีหมายเหตุ', // ใช้ค่าเริ่มต้นหาก note_item มีค่าเป็น null
      status: json['item_status'] as String,
    );
  }
}

class AppColors {
  static const Color titlebar = Color(0xFF026D81);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color buttonEdit = Color(0xFFEEB75D);
  static const Color card = Color(0xFFF1E6D9);
  static const Color botton = Color(0xFF0E4E89);
  static const Color textstatus = Color(0xFFEEB75D);
  static const Map<String, Color> statusColors = {
    'กําลังปรุง': Color(0xFFEEB75D), // สีสำหรับสถานะที่ 1
    'เสิร์ฟแล้ว': Color(0xFF8DB5AD), // สีสำหรับสถานะที่ 2
    'ยกเลิก': Color(0xFFB00020), // สีสำหรับสถานะที่ 3
  };
}
