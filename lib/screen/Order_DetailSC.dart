import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workshop2test/screen/User_menu_Order.dart';

class OrderDetail extends StatefulWidget {
  final String mealId;

  const OrderDetail({Key? key, required this.mealId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late Future<Map<String, dynamic>> mealData;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    mealData = _fetchMealData();
  }

  Future<Map<String, dynamic>> _fetchMealData() async {
    var response =
        await http.get(Uri.parse('http://127.0.0.1:5000/Orders/menus'));
    var imageResponse =
        await http.get(Uri.parse('http://127.0.0.1:5000/Orders/pic_url'));

    if (response.statusCode == 200 && imageResponse.statusCode == 200) {
      List<dynamic> menuData = json.decode(response.body);
      List<String> imageData = json.decode(imageResponse.body).cast<String>();

      Map<String, dynamic> meal = menuData.firstWhere(
        (item) => item['item_id'].toString() == widget.mealId,
        orElse: () => throw Exception('Meal not found'),
      );
      int imageIndex = menuData.indexOf(meal);
      String imageUrl = imageData.isNotEmpty
          ? imageData[imageIndex]
          : 'https://example.com/default_image.jpg';

      return {
        'meal': meal,
        'imageUrl': imageUrl,
      };
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 4, 82, 200),
            size: 50,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => User_menu_Order()));
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: mealData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('ไม่พบข้อมูล'),
            );
          }

          Map<String, dynamic> mealDetails = snapshot.data!;
          Map<String, dynamic> meal = mealDetails['meal'];
          String imageUrl = mealDetails['imageUrl'];

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                Container(
                  width: 400, // กำหนดขนาดที่คุณต้องการ
                  height: 400, // กำหนดขนาดที่คุณต้องการ
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors
                        .errorColorGreen, // ใช้สีที่คุณต้องการให้กับกรอบ
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        20.0), // ปรับขนาดของกรอบที่คุณต้องการ
                    child: ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 100, // กำหนดขนาดที่คุณต้องการ
                        height: 100, // กำหนดขนาดที่คุณต้องการ
                        fit: BoxFit.cover, // ให้รูปภาพเต็มกรอบ
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${meal['item_name']}                           ${meal['item_price']}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'หมวดหมู่: ${meal['category_id']} ${meal['item_description']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'หมายเหตุ',
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.errorColor02),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.errorColor02),
                          ),
                          hintText: 'กรุณาระบุหมายเหตุ ext. ไม่ผัก',
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.errorColorOrenc,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '   $quantity   ',
                              style: const TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.errorColorOrenc,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'meal': meal,
                        'quantity': quantity,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 60),
                      backgroundColor: AppColors.primaryColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'ยืนยัน',
                      style: TextStyle(
                          color: Color.fromARGB(255, 246, 248, 248),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
}
