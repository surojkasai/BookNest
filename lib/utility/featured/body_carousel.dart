import 'package:booknest/utility/task_buttons.dart';
import 'package:flutter/material.dart';
import 'package:booknest/main.dart';

//featured carousel
class CategoryCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String image;

  const CategoryCard({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, height: 260, fit: BoxFit.cover),
            ),
            SizedBox(height: 8),

            Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
