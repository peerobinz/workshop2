import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2test/Dialog/Admin_CancelEdit.dart';
import 'package:workshop2test/Dialog/Admin_ConfirmEdit.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/admin/Admin_Stock.dart';

class Admin_StockEdit extends StatefulWidget {
  final int itemId; // ต้องการ itemId เพื่อโหลดข้อมูล

  const Admin_StockEdit({super.key, required this.itemId});

  @override
  State<Admin_StockEdit> createState() => _Admin_StockEditState();
}

class _Admin_StockEditState extends State<Admin_StockEdit> {
  String? selectedProduct;
  File? _image;
  final picker = ImagePicker();
  String? itemName;
  double? itemPrice;
  String? imageUrl; // เพิ่มตัวแปรสำหรับ URL รูปภา

  @override
  void initState() {
    super.initState();
    fetchMenuItem(widget.itemId).then((data) {
      if (data != null) {
        setState(() {
          itemName = data['item_name'];
          itemPrice = data['item_price'].toDouble();
          selectedProduct = data['category_id'].toString();
          // โหลดรูปภาพถ้ามี
        });
      }
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Map<String, dynamic>?> fetchMenuItem(int itemId) async {
    var url = Uri.parse('http://127.0.0.1:5000/adminstock/menu/$itemId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<bool> updateMenuItem(int itemId, Map<String, dynamic> data) async {
    var url = Uri.parse('http://127.0.0.1:5000/adminstock/editmenu/$itemId');
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'แก้ไขรายละเอียดสินค้า',
          style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 250.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "อัพโหลดรูปภาพ",
                  style:
                      TextStyle(color: AppColors.secondaryColor, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: getImage,
              child: Container(
                width: 380,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.photo),
                  image: DecorationImage(
                    image: _image != null
                        ? FileImage(_image!)
                        : (imageUrl != null
                                ? NetworkImage(imageUrl!)
                                : const AssetImage('path/to/placeholder.png'))
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
                child: _image == null && imageUrl == null
                    ? const Icon(Icons.image, size: 100, color: AppColors.photo)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('รายการ ',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                SizedBox(
                  width: 330,
                  child: TextField(
                    controller: TextEditingController(text: itemName),
                    onChanged: (value) {
                      itemName = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ราคา\t\t\t\t ',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                SizedBox(
                  width: 330,
                  child: TextField(
                    controller:
                        TextEditingController(text: itemPrice?.toString()),
                    onChanged: (value) {
                      itemPrice = double.tryParse(value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('หมวดหมู่',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                const SizedBox(width: 10),
                Container(
                  width: 310,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedProduct,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem<String>(
                          value: '3',
                          child: Text('003'),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('002'),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text('001'),
                        ),
                      ],
                      hint: const Text('หมวดหมู่'),
                      onChanged: (value) {
                        setState(() {
                          selectedProduct = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 670.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool? result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return const Admin_CancelEdit();
                          },
                        );

                        if (result == false) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Admin_Stock(),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFBBBBBB)),
                        textStyle: MaterialStateProperty.all(MyText.button),
                        fixedSize:
                            MaterialStateProperty.all(const Size(100, 40)),
                      ),
                      child: const Text('ยกเลิก'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        bool? result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return const Admin_ConfirmEdit();
                          },
                        );

                        if (result == true) {
                          // อัปเดตข้อมูลสินค้า
                          if (itemName != null &&
                              itemPrice != null &&
                              selectedProduct != null) {
                            await updateMenuItem(widget.itemId, {
                              'item_name': itemName,
                              'item_price': itemPrice,
                              'category_id': int.parse(selectedProduct!),
                              // ส่งข้อมูลรูปภาพถ้ามี
                            });
                          }

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Admin_Stock(),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                        textStyle: MaterialStateProperty.all(MyText.button),
                        fixedSize:
                            MaterialStateProperty.all(const Size(150, 40)),
                      ),
                      child: const Text('บันทึกข้อมูล'),
                    ),
                  ],
                ),
              ),
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
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color tabelOff = Color(0xFF8DB5AD);
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color photo = Color(0xFFD9D9D9);
}
