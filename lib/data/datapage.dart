import 'package:flutter/material.dart';
import 'package:workshop2test/data/database.dart';

class DatabaseTestPage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Connection Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await dbHelper.fetchData();
          },
          child: Text('Test Connection'),
        ),
      ),
    );
  }
}
