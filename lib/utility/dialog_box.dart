import 'package:booknest/utility/task_buttons.dart';
import 'package:flutter/material.dart';
import 'package:booknest/main.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 54, 54, 54),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(hintText: "Enter your mail"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TaskButtons(text: "Save", onPressed: onSave),
                  const SizedBox(width: 10),
                  TaskButtons(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
