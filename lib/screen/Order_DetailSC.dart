import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:workshop2test/manu/meal.dart';

class OrderDetail extends StatefulWidget {
  final String mealId;

  const OrderDetail({Key? key, required this.mealId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late Future<Meal> mealData;

  @override
  void initState() {
    super.initState();
    mealData = _fetchMealData();
  }

  Future<Meal> _fetchMealData() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealData = Map<String, dynamic>.from(data['meals'][0]);

      return Meal(
        id: mealData['idMeal'] ?? '',
        name: mealData['strMeal'] ?? 'ไม่มีชื่อ',
        category: mealData['strCategory'] ?? 'ไม่มีหมวดหมู่',
        imageUrl: mealData['strMealThumb'] ?? 'url รูปไม่พร้อมใช้งาน',
        instructions: mealData['strInstructions'] ?? 'ไม่มีคำแนะนำ',
      );
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดเมนูอาหาร'),
        backgroundColor: AppColors.primaryColor,
       
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
                Image.network(meal.imageUrl),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'หมวดหมู่: ${meal.category}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'หมายเหตุ',
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              // Logic ลดจำนวน
                            },
                          ),
                          const Text('1'), // แสดงจำนวนที่เลือก
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              // Logic เพิ่มจำนวน
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Logic ส่งข้อมูลกลับไปยังหน้า UserOrder
                        },
                        child: Text('ยืนยัน'),
                      ),
                    ],
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
}
