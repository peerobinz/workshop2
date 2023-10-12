//import screen
import 'package:flutter/material.dart';


import 'package:workshop2test/screen/User_OrderSC.dart';
import 'package:workshop2test/screen/User_PeymentSC.dart';
import 'package:workshop2test/screen/User_StatusSC.dart';

//import widget

//import add-on
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Ink(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 194, 194, 194),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(150.0),
                    //child: Image.asset('assets/your_image.png'), //ใส่รูปร้าน
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserOrder()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(250, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust this value for the desired corner radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'สั่งอาหาร',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserStatus(
                                selectedMeals: [],
                              )),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(250, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust this value for the desired corner radius
                      ),
                    ),
                  ),
                  child: Text(
                    'สถานะ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                 //  Navigator.push(
                   //   context,
                    //  MaterialPageRoute(builder: (context) => PaymentPage()),
                 //   );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(250, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust this value for the desired corner radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'เช็คบิล',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(250, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust this value for the desired corner radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'เเอดมิน',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 50),
          //ElevatedButton(
          //  onPressed: () {
            //  Navigator.push(
             //   context,
             //   MaterialPageRoute(builder: (context) => DatabaseTestPage()),
            //  );
           // },
          //  style: ButtonStyle(
          //    backgroundColor: MaterialStateProperty.all<Color>(
           //     AppColors.primaryColor,
           //   ),
           //   fixedSize:
           //       MaterialStateProperty.all<Size>(const Size(250, 60)),
           //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
           //     RoundedRectangleBorder(
            //      borderRadius: BorderRadius.circular(
            //          15), // Adjust this value for the desired corner radius
            //    ),
           //   ),
         //   ),
         //   child: const Text(
          //    'ทดสอบการเชื่อมต่อ',
          //    style: TextStyle(color: Colors.white, fontSize: 20),
         //   ),
         // ),
              ],
            ),
          ],
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
