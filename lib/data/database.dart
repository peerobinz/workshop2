import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  MySqlConnection? _conn;

  Future<bool> connectToDatabase() async {
    try {
      _conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql-peerobinz-peerobinz.aivencloud.com',
        port: 13806,
        user: 'avnadmin',
        db: 'AppNotification',
        password: 'AVNS_zMGhESqA5uEbOxeWshl',
      ));

      return true; // การเชื่อมต่อสำเร็จ
    } catch (e, s) {
      print('Exception: $e\nStack Trace: $s');
      return false; // การเชื่อมต่อล้มเหลว
    }
  }

  Future<void> closeConnection() async {
    await _conn?.close();
  }

  Future<List<Map<String, dynamic>>> fetchMenuItems() async {
    try {
      final results = await _conn!.query(
          'SELECT item_id, item_name, item_description, item_price, item_picture_url, category_id FROM MenuItems');

      return results.map((result) {
        return {
          'item_id': result['item_id'],
          'item_name': result['item_name'],
          'item_description': result['item_description'],
          'item_price': result['item_price'],
          'item_picture_url': result['item_picture_url'],
          'category_id': result['category_id'],
        };
      }).toList();
    } catch (e, s) {
      print('Exception: $e\nStack Trace: $s');
      return [];
    }
  }
}
