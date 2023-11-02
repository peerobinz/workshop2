import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Items',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> menuItems;
  late Future<List<String>> imageUrls;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    menuItems = fetchMenuItems();
    imageUrls = fetchImageUrls();
  }

  Future<List<dynamic>> fetchMenuItems() async {
    var url = Uri.parse('http://127.0.0.1:5000/Orders/menus');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load menu items: ${response.statusCode}');
    }
  }

  Future<List<String>> fetchImageUrls() async {
    var response =
        await http.get(Uri.parse('http://127.0.0.1:5000/Orders/pic_url'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.cast<String>();
    } else {
      throw Exception('Failed to load image URLs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: AppColors.secondaryColor,
            size: 35,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        title: Text('เมนู',
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 32)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              color: AppColors.secondaryColor,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([menuItems, imageUrls]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> menuData = snapshot.data![0];
            List<String> imageData = snapshot.data![1];

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'ค้นหาเมนูอาหาร',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        // Implement search functionality
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'รายการอาหาร',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuData.length,
                    itemBuilder: (context, index) {
                      var item = menuData[index];
                      String itemName = item['item_name'] ?? 'No Name';
                      String itemPrice = (item['item_price'] is num)
                          ? item['item_price'].toString()
                          : 'No Price';
                      String itemPictureUrl =
                          imageData.isNotEmpty ? imageData[index] : 'No URL';

                      return ListTile(
                        leading: itemPictureUrl != 'No URL'
                            ? Image.network(itemPictureUrl,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : null,
                        title: Text(itemName),
                        subtitle: Text('Price: $itemPrice'),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: AppColors.secondaryColor,
                          ),
                          onPressed: () {
                            // Add functionality for adding item to cart or list
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
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
}
