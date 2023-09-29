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
              color: Color.fromARGB(255, 110, 56, 5),
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket,
              color: Color.fromARGB(255, 110, 56, 5),
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
            color: Color.fromARGB(255, 110, 56, 5),
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
                  color: Color.fromARGB(255, 110, 56, 5),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderConfirm(
                        selectedMeals: selectedMeals.values.toList())),
              );
            },
            child: Text('ยืนยันรายการ (${selectedMeals.length} รายการ)'),
          ),
        ],
      ),
    );
  }
}
