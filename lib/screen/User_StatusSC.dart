<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/services_dialog.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/manu/meal.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:workshop2test/screen/User_PeymentSC.dart';

class UserStatus extends StatefulWidget {
  final List<Meal> selectedMeals;

  const UserStatus({Key? key, required this.selectedMeals}) : super(key: key);

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 50.0, // ระบุความสูงของ SliverAppBar
            floating: false, // กำหนดให้ SliverAppBar ไม่ลอยขึ้นเมื่อเลื่อนลง
            pinned: true, // กำหนดให้ SliverAppBar คงอยู่ด้านบนเสมอ
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'สถานะ',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 30,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.receipt,
                  color: AppColors.secondaryColor,
                  size: 40.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()),
                  );
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.notification_add,
                color: AppColors.secondaryColor,
                size: 40.0,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ServicesDialog();
                  },
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final selectedMeal = widget.selectedMeals[index];
                return ListTile(
                  title: Text(selectedMeal.name),
                  subtitle: Text(selectedMeal.category),
                  leading: Image.network(selectedMeal.imageUrl),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('จำนวน: ${selectedMeal.quantity}'),
                      const Text(
                        'สถานะ: กำลังปรุง', // เพิ่มส่วนแสดงสถานะที่นี่
                        style: TextStyle(
                          color: Colors.orange, // สีส้มหรือสีที่คุณต้องการ
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: widget.selectedMeals.length,
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainMenu()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'HOME',
          style: MyText.buttoncomfirm,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  // ... add more colors as needed
}
=======
//import screen


//import widget


//import add-on
>>>>>>> developer
