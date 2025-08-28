import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:booknest/main.dart';

class TaskButtons extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  TaskButtons({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text(text),
    );
  }
}
