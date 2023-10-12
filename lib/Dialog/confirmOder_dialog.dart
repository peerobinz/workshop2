import 'package:flutter/material.dart';
import 'package:workshop2test/Text/my_text.dart';
import 'package:workshop2test/manu/meal.dart';

import 'package:workshop2test/screen/User_StatusSC.dart';

class ConfirmationDialog extends StatefulWidget {
  final List<Meal> selectedMeals;

  const ConfirmationDialog({Key? key, required this.selectedMeals})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  void initState() {
    super.initState();
    // เมื่อแสดง Dialog เสร็จแล้ว
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserStatus(selectedMeals: widget.selectedMeals),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Icon(Icons.checklist, size: 57, color: Color.fromARGB(255, 174, 13, 13)),
          const SizedBox(height: 20),
          const Text('ทำรายการเสร็จสิ้น', style: MyText.basic),
          const SizedBox(height: 20),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
