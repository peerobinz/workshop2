import 'package:flutter/material.dart';
import 'package:workshop2test/admin/Admin_Checkbill.dart';
import 'package:workshop2test/admin/Admin_Dashboard.dart';
import 'package:workshop2test/admin/Admin_Order.dart';
import 'package:workshop2test/admin/Admin_Queue.dart';
import 'package:workshop2test/admin/Admin_Stock.dart';
import 'package:workshop2test/admin/Admin_Table.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double containerWidth;
            if (constraints.maxWidth > 600) {
              containerWidth = 250;
            } else {
              containerWidth = constraints.maxWidth * 0.4;
            }
            return Row(
              children: [
                Container(
                  width: containerWidth,
                  padding: const EdgeInsets.only(top: 50),
                  color: AppColors.primaryColor,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: List.generate(6, (index) {
                        return RotatedBox(
                          quarterTurns: 1,
                          child: Column(
                            children: [
                             
                                getIconForTab(index),
                                
                              
                              Text(getPageName(index)),
                              const Divider(
                                color: Color.fromARGB(255, 255, 255, 255),
                                thickness: 2,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      Admin_Stock(),
                      Admin_Dashboard(),
                      Admin_checkbill(),
                      Admin_Order(),
                      Admin_Table(),
                      Admin_Queue(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getIconForTab(int index) {
     switch (index) {
    case 0:
      return Image.asset('assets/icons8-stock-64.png', width: 50, height: 50,);
    case 1:
      return Image.asset('assets/icons8-dashboard-64.png', width: 50, height: 50,);
    case 2:
      return Image.asset('assets/icons8-money-64.png', width: 50, height: 50,);
    case 3:
      return Image.asset('assets/icons8-chef-hat-100.png', width: 50, height: 50,);
    case 4:
      return Image.asset('assets/icons8-table-60.png', width: 50, height: 50,);
    case 5:
      return Image.asset('assets/icons8-create-order-96.png', width: 50, height: 50,);
    
    default:
      return const Icon(Icons.error,size: 50,);
  }
}

 

  String getPageName(int index) {
    switch (index) {
      case 0:
        return 'คลังสินค้า';
      case 1:
        return 'รายงาน';
      case 2:
        return 'เช็คบิล';
      case 3:
        return 'ออเดอร์';
      case 4:
        return 'โต๊ะ';
      case 5:
        return 'คิว';
      default:
        return '';
    }
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color tableOn = Color(0xFFECAE7D);
  static const Color tabelOff = Color(0xFF8DB5AD);
}
