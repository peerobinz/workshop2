import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchMenuItems() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:5000/Orders/menus'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load menu items');
  }
}

Future<List<dynamic>> fetchtable() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/table'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load menu items');
  }
}

Future<String> fetchImageUrl() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:5000/Orders/pic_url'));
  if (response.statusCode == 200) {
    // สมมติว่า URL รูปภาพอยู่ใน body ของ response
    return response.body;
  } else {
    throw Exception('Failed to load image URL');
  }
}
