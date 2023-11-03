import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2test/screen/MainManuSC.dart';
import 'dart:convert';

import 'package:workshop2test/screen/Order_ConfirmSC.dart';

class User_menu_Order extends StatefulWidget {
  final List<dynamic> selectedMenuItems;
  User_menu_Order({Key? key, required this.selectedMenuItems})
      : super(key: key);
  @override
  _User_menu_OrderState createState() => _User_menu_OrderState();
}

class _User_menu_OrderState extends State<User_menu_Order> {
  late Future<List<dynamic>> menuItems;
  late Future<List<String>> imageUrls;

  TextEditingController _searchController = TextEditingController();
  late List<dynamic> selectedMenuItems;
  @override
  void initState() {
    super.initState();
    menuItems = fetchMenuItems();
    imageUrls = fetchImageUrls();
    selectedMenuItems =
        widget.selectedMenuItems; // Use the passed selectedMenuItems
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

  void addItemToCart(dynamic menuItem) {
    setState(() {
      widget.selectedMenuItems
          .add(menuItem); // Use the passed selectedMenuItems
    });
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainMenu()),
            );
          },
        ),
        backgroundColor: Colors.white,
        title: Text('เมนู',
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 32)),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  color: AppColors.secondaryColor,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderConfirm(
                            selectedMenuItems:
                                widget.selectedMenuItems.toList())),
                  );
                },
              ),
              if (widget.selectedMenuItems.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    child: Text(
                      widget.selectedMenuItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
            ],
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
                      padding: EdgeInsets.all(16.0),
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
                        subtitle: Text('ราคา : $itemPrice'),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: AppColors.secondaryColor,
                          ),
                          onPressed: () {
                            addItemToCart(item);
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
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
                builder: (context) =>
                    OrderConfirm(selectedMenuItems: widget.selectedMenuItems),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${widget.selectedMenuItems.length}',
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
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  // ... add more colors as needed
}
