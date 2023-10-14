import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getDbConnection() async {
  return await MySqlConnection.connect(ConnectionSettings(
    host: 'mysql-peerobinz-peerobinz.aivencloud.com',
    port: 13806,
    user: 'avnadmin',
    db: 'AppNotification',
    password: 'AVNS_zMGhESqA5uEbOxeWshl',
  ));
}

Future<List<Map<String, dynamic>>> fetchCategories(String procedureName) async {
  try {
    final conn = await getDbConnection();
    var results = await conn.query('CALL $procedureName()');
    await conn.close();
    return results.map((row) => {
      'id': row[0], 
      'name': row[1], 
      'description': row[2]
    }).toList();
  } catch (e) {
    print('Error fetching categories: $e');
    return [];
  }
}
