import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';
import 'package:flutter/material.dart';
import 'package:booknest/db/book.dart';
import 'dart:typed_data';

class HorizontalBookList extends StatelessWidget {
  final String? sectionTitle;

  final List<Book> books;

  const HorizontalBookList({super.key, this.sectionTitle, required this.books});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalPadding = 40.0 * 2;

        final spacing = 10.0 * (books.length - 1).clamp(0, double.infinity);
        final availableWidth = screenWidth - horizontalPadding;

        final itemWidth = (availableWidth - spacing) / 6;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionTitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                child: Text(
                  sectionTitle!,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 20,
                children:
                    books.map((book) {
                      return SizedBox(
                        width: itemWidth,
                        height: 350,
                        child: BookItemCard(
                          title: book.title,
                          imageBytes: book.imageBytes,
                          price: book.price,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BookDetailsPage(
                                      titleText: sectionTitle ?? "",
                                      capText:
                                          'Find Your Next Great Read'
                                          '${sectionTitle != null ? " Among Our $sectionTitle" : ""}',
                                      title: book.title,
                                      imageBytes: book.imageBytes,
                                      price: book.price,
                                      author: book.author,
                                      description: book.description,
                                    ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
