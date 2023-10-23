import 'package:flutter/material.dart';
import 'package:workshop2test/Dialog/Admin_CancelEdit.dart';
import 'package:workshop2test/Dialog/Admin_ConfirmAdd.dart';
import 'package:workshop2test/Dialog/Admin_ConfirmEdit.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:workshop2test/admin/Admin_Stock.dart';

class Admin_StockAdd extends StatefulWidget {
  const Admin_StockAdd({super.key});

  @override
  _Admin_StockAddState createState() => _Admin_StockAddState();
}

class _Admin_StockAddState extends State<Admin_StockAdd> {
  String? selectedProduct;
  File? _image;
  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'รายละเอียดสินค้า',
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
                  image: _image == null
                      ? null
                      : DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                ),
                child: _image == null
                    ? const Icon(Icons.image, size: 100, color: AppColors.photo)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('รายการ ',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                SizedBox(
                  width: 330,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ราคา\t\t\t\t ',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                SizedBox(
                  width: 330,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('สินค้า  ',
                    style: TextStyle(
                        color: AppColors.secondaryColor, fontSize: 20)),
                const SizedBox(width: 10),
                Container(
                  width: 330,
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
                          value: '1',
                          child: Text('002'),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text('001'),
                        ),
                      ],
                      hint: const Text('สินค้า'),
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
                          // ทำการนำทางไปยังหน้า Admin_Stock เมื่อกดปุ่ม ยืนยัน
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Admin_Stock(),
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
                            return const Admin_ConfirmAdd();
                          },
                        );

                        if (result == true) {
                          // ทำการนำทางไปยังหน้า Admin_Stock เมื่อกดปุ่ม ยืนยัน
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Admin_Stock(),
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
