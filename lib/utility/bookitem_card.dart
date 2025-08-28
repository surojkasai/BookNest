import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookItemCard extends StatelessWidget {
  final String title;
  //final String imagePath;
  final Uint8List? imageBytes;
  final double price;
  final VoidCallback? onTap;

  const BookItemCard({
    super.key,
    required this.title,
    //required this.imagePath,
    this.imageBytes,
    required this.price,
    this.onTap,
  });

  //this defines  the book and its details
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
                      child:
                          imageBytes != null && imageBytes!.isNotEmpty
                              ? Image.memory(
                                imageBytes!,
                                height: 300,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                color: Theme.of(context).secondaryHeaderColor,
                                child: Icon(
                                  Icons.book,
                                  size: 80,
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                      //Image.asset(imagePath, width: 200, height: 300, fit: BoxFit.cover),
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
