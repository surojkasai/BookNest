import 'package:flutter/material.dart';

class BookItemCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final int price;
  final VoidCallback? onTap;

  const BookItemCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
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
                    'Rs.$price',
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
      ),
    );
  }
}
