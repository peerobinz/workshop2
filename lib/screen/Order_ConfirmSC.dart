import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/confirmOder_dialog.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/manu/meal.dart';
import 'package:workshop2test/screen/User_StatusSC.dart';

class OrderConfirm extends StatefulWidget {
  final List<Meal> selectedMeals;

  const OrderConfirm({Key? key, required this.selectedMeals}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(101, 34, 0, 0),
                    child: Text(
                      'รายการอาหาร',
                      style: MyText.headline,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 68, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'รายการ',
                          style: MyText.subheading,
                        ),
                        Text(
                          'จำนวนรายการ: ${widget.selectedMeals.length}',
                          style: MyText.subheading,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedMeals.length,
                      itemBuilder: (context, index) {
                        final selectedMeal = widget.selectedMeals[index];
                        return ListTile(
                          title: Text(selectedMeal.name),
                          subtitle: Text(selectedMeal.category),
                          leading: Image.network(selectedMeal.imageUrl),
                          trailing: Text(
                              'จำนวน: ${selectedMeal.quantity}'), // แสดงจำนวน
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
                      bool result = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                              selectedMeals: widget.selectedMeals);
                        },
                      );

                      if (result == true) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserStatus(
                              selectedMeals: widget.selectedMeals,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
  static const Color errorColor = Color(0xFFB00020);
  // ... add more colors as needed
}
