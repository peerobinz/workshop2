import 'package:flutter/material.dart';
import 'package:workshop2test/admin/Admin_Checkbill.dart';
import 'package:workshop2test/admin/Admin_Dashboard.dart';
import 'package:workshop2test/admin/Admin_Order.dart';
import 'package:workshop2test/admin/Admin_Queue.dart';
import 'package:workshop2test/admin/Admin_Stock.dart';
import 'package:workshop2test/admin/Admin_Table.dart';

class MainAdmin extends StatefulWidget {
  MainAdmin({Key? key}) : super(key: key);

  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: Row(
          children: [
            _buildTabBar(),
            Expanded(
              child: Navigator(
                key: navigatorKey,
                onGenerateRoute: (settings) {
                  // ตรงนี้คือการเลือกหน้าที่ต้องการแสดงตาม route name
                  switch (settings.name) {
                    case 'stock':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_Stock());
                    case 'dashboard':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_Dashboard());
                    case 'checkbill':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_checkbill());
                    case 'order':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_Order());
                    case 'table':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_Table());
                    case 'queue':
                      return MaterialPageRoute(
                          builder: (context) => const Admin_Queue());
                    default:
                      return MaterialPageRoute(
                          builder: (context) => Container()); //หน้าเเรก
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Builder(
      builder: (context) => Container(
        width: 250,
        padding: const EdgeInsets.only(top: 50),
        color: AppColors.primaryColor,
        child: RotatedBox(
          quarterTurns: -1,
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              switch (index) {
                case 0:
                  navigatorKey.currentState!.pushReplacementNamed('stock');
                  break;
                case 1:
                  navigatorKey.currentState!.pushReplacementNamed('dashboard');
                  break;
                case 2:
                  navigatorKey.currentState!.pushReplacementNamed('checkbill');
                  break;
                case 3:
                  navigatorKey.currentState!.pushReplacementNamed('order');
                  break;
                case 4:
                  navigatorKey.currentState!.pushReplacementNamed('table');
                  break;
                case 5:
                  navigatorKey.currentState!.pushReplacementNamed('queue');
                  break;
              }
            },
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(6, (index) {
              return RotatedBox(
                quarterTurns: 1,
                child: Container(
                
                  child: Column(
                    children: [
                      getIconForTab(index, _tabController.index == index),
                      getPageName(index, _tabController.index == index),
                      const Divider(
                        color: AppColors.W,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget getIconForTab(int index, bool isSelected) {
    Color? tintColor;
    if (isSelected) {
      tintColor = AppColors.tableOn;
    } else {
      tintColor = AppColors.W;
    } //กำหนดสี

    switch (index) {
      case 0:
        return Image.asset(
          'assets/icons8-stock-64.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      case 1:
        return Image.asset(
          'assets/icons8-dashboard-64.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      case 2:
        return Image.asset(
          'assets/icons8-money-64.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      case 3:
        return Image.asset(
          'assets/icons8-chef-hat-100.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      case 4:
        return Image.asset(
          'assets/icons8-table-60.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      case 5:
        return Image.asset(
          'assets/icons8-create-order-96.png',
          width: 50,
          height: 70,
          color: tintColor,
        );
      default:
        return const Icon(
          Icons.error,
          size: 10,
        );
    }
  }

  Widget getPageName(int index, bool isSelected) {
    Color? textColor =
        isSelected ? AppColors.tableOn : AppColors.W; // กำหนดสีดิเห้ย...

    switch (index) {
      case 0:
        return Text('คลังสินค้า', style: TextStyle(color: textColor));
      case 1:
        return Text('รายงาน', style: TextStyle(color: textColor));
      case 2:
        return Text('เช็คบิล', style: TextStyle(color: textColor));
      case 3:
        return Text('ออเดอร์', style: TextStyle(color: textColor));
      case 4:
        return Text('โต๊ะ', style: TextStyle(color: textColor));
      case 5:
        return Text('คิว', style: TextStyle(color: textColor));
      default:
        return Text('', style: TextStyle(color: textColor));
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
  static const Color W = Color(0xFFFFFCFC);
}
