import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2test/manu/meal.dart';
import 'dart:convert';
import 'package:workshop2test/screen/MainManuSC.dart';
import 'package:workshop2test/screen/Order_ConfirmSC.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {

  List<Meal> meals = [];
  Map<String, Meal> selectedMeals = {};

  void _incrementMealQuantity(Meal meal) {
    setState(() {
      if (selectedMeals.containsKey(meal.id)) {
        selectedMeals[meal.id]!.quantity++;
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
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=Chicken'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealsData = List<Map<String, dynamic>>.from(data['meals']);
      final fetchedMeals = mealsData
          .map((mealData) => Meal(
                id: mealData['idMeal'] ?? '',
                name: mealData['strMeal'] ?? 'ไม่มีชื่อ',
                category: mealData['strCategory'] ?? 'ไม่มีหมวดหมู่',
                imageUrl: mealData['strMealThumb'] ?? 'url รูปไม่พร้อมใช้งาน',
                instructions: '',
              ))
          .toList();

      setState(() {
        meals = fetchedMeals;
      });
    } else {
      throw Exception('Failed to load meals');
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
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _decrementMealQuantity(meal);
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(meal.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _incrementMealQuantity(meal);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      final mealId = meal.id;
                      if (!selectedMeals.containsKey(mealId)) {
                        meal.quantity = 1;
                        selectedMeals[mealId] = meal;
                      }
                    });
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
              fixedSize: MaterialStateProperty.all<Size>(
                  Size(250, 60)), // ปรับขนาดที่นี่
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // ปรับความโค้งที่นี่
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
                    '${selectedMeals.length}',
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
}