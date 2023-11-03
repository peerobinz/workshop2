import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:workshop2test/Dialog/confirmPayment_dialog.dart';
import 'package:workshop2test/screen/MainManuSC.dart';

class PaymentPage extends StatefulWidget {
  final num orderId;

  const PaymentPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Future<PaymentSummary> fetchPaymentSummary() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/payment-summary/${widget.orderId}'),
    );

    if (response.statusCode == 200) {
      return PaymentSummary.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load payment summary');
    }
  }

  String _getCurrentDateTime() {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'ชำระเงิน',
          style: TextStyle(
              fontSize: 22,
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<PaymentSummary>(
        future: fetchPaymentSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return Text("No data found");
          }

          PaymentSummary summary = snapshot.data!;
          num vat = summary.totalPrice * 0.07;
          num totalPriceWithVat = summary.totalPrice + vat;

          return Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'วันที่: ${_getCurrentDateTime().split(' ')[0]}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'เวลา: ${_getCurrentDateTime().split(' ')[1]}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: summary.items.length,
                  itemBuilder: (context, index) {
                    var item = summary.items[index];
                    return ListTile(
                      title: Text(
                        item['menu_item_name'],
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text('จำนวน: ${item['quantity']} '),
                      trailing: Text('ราคา: ${item['item_total_price']} บาท'),
                    );
                  },
                ),
              ),
              Text('ราคารวม: ${summary.totalPrice} THB',
                  style: TextStyle(fontSize: 20)),
              Text('VAT 7%: ${vat.toStringAsFixed(2)} THB',
                  style: TextStyle(fontSize: 20)),
              Text('รวมทั้งหมด: ${totalPriceWithVat.toStringAsFixed(2)} THB',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ConfirmPaymentDialog();
                    },
                  );
                },
                child: Text(
                  'ยืนยันรายการ',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor, fixedSize: Size(200, 50)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenu()),
                  );
                },
                child: Text(
                  'กลับหน้าหลัก',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.errorColor02, fixedSize: Size(200, 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSummary {
  final num orderId;
  final List<dynamic> items;
  final num totalPrice;

  PaymentSummary({
    required this.orderId,
    required this.items,
    required this.totalPrice,
  });

  factory PaymentSummary.fromJson(Map<String, dynamic> json) {
    return PaymentSummary(
      orderId: json['order_id'],
      items: json['items'],
      totalPrice: json['total_price'],
    );
  }
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
