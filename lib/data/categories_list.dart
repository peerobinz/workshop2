import 'package:flutter/material.dart';
import 'db_helper.dart'; 

class CategoriesList extends StatelessWidget {
  final String procedureName;

  CategoriesList({required this.procedureName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCategories(procedureName), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No categories found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]['name'] ?? ''),
                subtitle: Text(snapshot.data![index]['description'] ?? ''),
              );
            },
          );
        }
      },
    );
  }
}
