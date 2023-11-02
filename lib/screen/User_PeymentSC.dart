import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/confirmPayment_dialog.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:intl/intl.dart'; // For date formatting

class PaymentPage extends StatefulWidget {
  final List<dynamic>
      selectedMenuItems; // Changed from List<Meal> to List<dynamic>

  const PaymentPage({Key? key, required this.selectedMenuItems})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double calculateTotal() {
    double total = 0.0;
    for (var item in widget.selectedMenuItems) {
      total +=
          item['price'] * item['quantity']; // Changed to use dynamic access
    }
    return total;
  }

  double calculateVAT(double total) {
    return total * 0.07;
  }

  double calculateGrandTotal(double total, double vat) {
    return total + vat;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();
    double vat = calculateVAT(total);
    double grandTotal = calculateGrandTotal(total, vat);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ชำระเงิน',
          style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'โต๊ะ 5',
                  style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'วันที่: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'เวลา: ${DateFormat('HH:mm').format(DateTime.now())}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 16.0, bottom: 16.0),
              child: ListView(
                children: [
                  const Text(
                    'รายการสินค้า',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.selectedMenuItems.length,
                    itemBuilder: (context, index) {
                      final menuItem = widget.selectedMenuItems[index];
                      return ListTile(
                        title: Text(menuItem['name']),
                        subtitle: Text('จำนวน: ${menuItem['quantity']}'),
                        trailing: Text('ราคา: ${menuItem['price']}'),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Text('รวมทั้งสิน: ${total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  Text('Vat 7%: ${vat.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  Text(
                    'รวมสุทธิ: ${grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 60),
                    backgroundColor: AppColors.primaryColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('ยืนยันชำระเงิน',
                      style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 60),
                    backgroundColor: AppColors.errorColor02,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('กลับหน้าหลัก',
                      style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
}
