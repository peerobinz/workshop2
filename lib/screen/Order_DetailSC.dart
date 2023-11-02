

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:workshop2test/manu/meal.dart';
import 'package:workshop2test/screen/User_OrderSC.dart';

class OrderDetail extends StatefulWidget {
  final String mealId;

  const OrderDetail({Key? key, required this.mealId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late Future<Meal> mealData;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    mealData = _fetchMealData();
  }

  Future<Meal> _fetchMealData() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5000/OrderDetail/${widget.mealId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealData = Map<String, dynamic>.from(data['meals'][0]);

      return Meal(
        category: mealData['category_id'].toString(), 
        description: mealData['item_description'] ?? '',
        id: mealData['item_id'].toString(),
        name: mealData['item_name'] ?? 'No name',
         imageUrl: mealData['item_picture_url'] ??
                      'https://example.com/default_image.jpg',
        price: mealData['item_price'],
      );
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
            print("Back button pressed");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserOrder()));
          },
        ),
      ),
      body: FutureBuilder<Meal>(
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

          final meal = snapshot.data!;

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
                        meal.imageUrl,
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
                        '${meal.name}                           ${meal.price}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'หมวดหมู่: ${meal.category} ${meal.description}',
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
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
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
                                //สีเเละวงกลม
                                padding: const EdgeInsets.all(
                                    4), // ปรับ padding ตามที่คุณต้องการ
                                decoration: const BoxDecoration(
                                  color: AppColors
                                      .errorColorOrenc, // ใช้สีที่คุณต้องการ
                                  shape: BoxShape
                                      .circle, // ทำให้ Container มีรูปทรงวงกลม
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors
                                      .white, // ใช้สีที่คุณต้องการสำหรับ icon
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
                                //สีเเละวงกลม
                                padding: const EdgeInsets.all(
                                    4), // ปรับ padding ตามที่คุณต้องการ
                                decoration: const BoxDecoration(
                                  color: AppColors
                                      .errorColorOrenc, // ใช้สีที่คุณต้องการ
                                  shape: BoxShape
                                      .circle, // ทำให้ Container มีรูปทรงกลม
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white, // สีของไอคอน
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
                        'meal': snapshot.data,
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
