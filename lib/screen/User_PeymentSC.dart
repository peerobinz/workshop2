// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PaymentPage extends StatefulWidget {
//   final num orderId;

//   const PaymentPage({Key? key, required this.orderId}) : super(key: key);

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   bool isLoading = true;
//   double totalAmount = 0.0;
//   List<dynamic> orderItems = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchOrderDetails(widget.orderId);
//   }

//   Future<void> fetchOrderDetails(num orderId) async {
//     var url = Uri.parse('http://127.0.0.1:5000/payment/$orderId');
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);

//       setState(() {
//         totalAmount = data['total_amount'].toDouble();
//         orderItems = List<dynamic>.from(data['items']);
//         isLoading = false;
//       });
//     } else {
//       // จัดการข้อผิดพลาด
//       throw Exception('Failed to load order details');
//     }
//   }

//   double calculateVAT(double total) {
//     return total * 0.07;
//   }

//   double calculateGrandTotal(double total, double vat) {
//     return total + vat;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     double vat = calculateVAT(totalAmount);
//     double grandTotal = calculateGrandTotal(totalAmount, vat);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ชำระเงิน'),
//         // ... รายละเอียด AppBar อื่น ๆ
//       ),
//       body: Column(
//         children: [
//           // ... รายละเอียด UI อื่น ๆ
//           Expanded(
//             child: ListView.builder(
//               itemCount: orderItems.length,
//               itemBuilder: (context, index) {
//                 final item = orderItems[index];
//                 return ListTile(
//                   title: Text(item['name']),
//                   subtitle: Text('จำนวน: ${item['quantity']}'),
//                   trailing: Text('ราคา: ${item['price']}'),
//                 );
//               },
//             ),
//           ),
//           Text('รวมทั้งสิน: ${totalAmount.toStringAsFixed(2)}'),
//           Text('Vat 7%: ${vat.toStringAsFixed(2)}'),
//           Text('รวมสุทธิ: ${grandTotal.toStringAsFixed(2)}'),
//           // ... ปุ่มสำหรับชำระเงิน
//         ],
//       ),
//     );
//   }
// }
