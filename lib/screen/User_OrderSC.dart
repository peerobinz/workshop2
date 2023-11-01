import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workshop2test/manu/meal.dart';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:workshop2test/screen/Order_ConfirmSC.dart';
import 'package:workshop2test/screen/Order_DetailSC.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  List<Meal> meals = [];
  Map<String, Meal> selectedMeals = {};

  int _calculateTotalQuantity(Map<String, Meal> selectedMeals) {
    int totalQuantity = 0;
    selectedMeals.forEach((key, meal) {
      totalQuantity +=
          meal.quantity; // ตรวจสอบว่าคุณมี property `quantity` ใน class `Meal`
    });
    return totalQuantity;
  }

  void _incrementMealQuantity(Meal meal) {
    setState(() {
      if (selectedMeals.containsKey(meal.id)) {
        selectedMeals[meal.id]!.quantity++;
      } else {
        Meal newMeal = Meal(
          id: meal.id,
          name: meal.name,
          category: meal.category,
          imageUrl: meal.imageUrl,
          quantity: 1,
          price: meal.price,
          description: meal.description,
        );
        selectedMeals[meal.id] = newMeal;
      }
    });
  }

  void _decrementMealQuantity(Meal meal) {
    setState(() {
      if (selectedMeals.containsKey(meal.id)) {
        if (selectedMeals[meal.id]!.quantity > 1) {
          selectedMeals[meal.id]!.quantity--;
        } else {
          selectedMeals.remove(meal.id);
        }
      }
    });
  }

  Future<void> _fetchMeals() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/Orers/menus'), // URL ของ API ใหม่
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mealsData = List<Map<String, dynamic>>.from(data);
        final fetchedMeals = mealsData
            .map((mealData) => Meal(
                  id: mealData['item_id'].toString(),
                  name: mealData['item_name'],
                  imageUrl: mealData['item_picture_url'] ??
                      'https://example.com/default_image.jpg',
                  description: mealData['item_description'] ?? '',
                  price: double.parse(
                      mealData['item_price'].toString()), // แปลงราคาเป็น double

                  category: mealData['category_id'] ?? '',
                ))
            .toList();

        setState(() {
          meals = fetchedMeals;
        });
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      // จัดการ Exception หรือ Error ต่าง ๆ
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'เมนู',
            style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket,
              color: AppColors.secondaryColor,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderConfirm(
                        selectedMeals: selectedMeals.values.toList())),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: AppColors.secondaryColor,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาเมนูอาหาร',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'รายการอาหาร',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                final name = meal.name;
                final category = meal.category;
                final imageUrl = meal.imageUrl;

                return ListTile(
                  title: Text(name),
                  subtitle: Text(category),
                  leading: Image.network(imageUrl),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          _incrementMealQuantity(meal);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                              9), // ปรับ padding ตามที่คุณต้องการ
                          decoration: const BoxDecoration(
                            color:
                                AppColors.errorColorOrenc, // ใช้สีที่คุณต้องการ
                            shape:
                                BoxShape.circle, // ทำให้ Container มีรูปทรงกลม
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white, // สีของไอคอน
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final selectedMeal = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetail(mealId: meal.id),
                      ),
                    ) as Meal?;
                    if (selectedMeal != null) {
                      // Logic ที่จะทำเมื่อมีการเลือกรายการอาหาร
                      _incrementMealQuantity(selectedMeal);
                    }
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              fixedSize: MaterialStateProperty.all<Size>(const Size(250, 60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirm(
                      selectedMeals: selectedMeals.values.toList()),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${_calculateTotalQuantity(selectedMeals)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                const Text(
                  '   รายการที่รอส่ง',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          )
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
  static const Color errorColorOrenc = Color(0xFFED6335);
}
