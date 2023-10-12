import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  Future<void> fetchData() async {
    MySqlConnection? conn;

    try {
      conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql-peerobinz-peerobinz.aivencloud.com',
        port: 13806,
        user: 'avnadmin',
        db: 'AppNotification',
        password: 'AVNS_zMGhESqA5uEbOxeWshl',
      ));

      // If the code reaches here, connection is successful
      print('Connected to the database successfully.');

      final results = await conn.query(
        'SELECT item_id, item_name, item_description, item_price, item_picture_url FROM AppNotification.MenuItems'
      );

      for (var row in results) {
        print('Result: ${row[0]} ${row[1]}');
      }
    } catch (e, s) {
      print('Exception: $e\nStack Trace: $s');
    } finally {
      await conn?.close();
      print('Connection closed.');
    }
  }
}
