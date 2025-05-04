import 'package:booknest/main.dart';
import 'package:flutter/material.dart';

class BookItemCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;

  const BookItemCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 350,
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: 200,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Text(
                  price,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
