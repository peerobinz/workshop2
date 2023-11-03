import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/services_dialog.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/screen/User_PeymentSC.dart';
import 'package:workshop2test/screen/User_menu_Order.dart';

class UserStatus extends StatefulWidget {
  late final List<dynamic> selectedMenuItems;
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
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
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
                      builder: (context) => PaymentPage(
                          selectedMenuItems: widget.selectedMenuItems),
                    ),
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
                final menuItem = widget.selectedMenuItems[index];
                return ListTile(
                  title: Text(menuItem['name']),
                  subtitle: Text(menuItem['category']),
                  leading: Image.network(menuItem['imageUrl']),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('จำนวน: ${menuItem['quantity']}'),
                      const Text(
                        'สถานะ: กำลังปรุง',
                        style: TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: widget.selectedMenuItems.length,
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => User_menu_Order(
                      selectedMenuItems: [],
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          fixedSize: const Size(350, 60),
        ),
        child: const Text(
          'สั่งอาหาร',
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
