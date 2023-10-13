import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/confirmPayment_dialog.dart';
import 'package:workshop2test/manu/meal.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:intl/intl.dart'; //เวลา

class PaymentPage extends StatefulWidget {
  final List<Meal> selectedMeals;

  const PaymentPage({Key? key, required this.selectedMeals}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
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
                      'วันที่: ${DateFormat('dd/MM/').format(DateTime.now().toLocal())}${DateTime.now().year + 543}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'เวลา: ${DateFormat('HH:mm').format(DateTime.now().toLocal())}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.black, // กำหนดสีเป็นสีดำ
                  thickness: 1, // กำหนดความหนาของเส้น
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
                    shrinkWrap:
                        true, // ให้ ListView.builder ใช้พื้นที่เท่าที่จำเป็น
                    physics:
                        NeverScrollableScrollPhysics(), // ปิดการเลื่อนภายใน ListView.builder
                    itemCount: widget.selectedMeals.length,
                    itemBuilder: (context, index) {
                      final meal = widget.selectedMeals[index];
                      return ListTile(
                        title: Text(meal.name),
                        subtitle: Text(meal.category),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const Text('รวมทั้งสิน ', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  const Text('Vat 7 % ', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 5),
                  const Text(
                    'รวมสุทธิ ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                    minimumSize: const Size(250, 60),
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
                    minimumSize: const Size(250, 60),
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



