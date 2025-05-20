import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';
import 'package:flutter/material.dart';

class HorizontalBookList extends StatelessWidget {
  final String? sectionTitle;
  final List<Map<String, dynamic>> books;

  const HorizontalBookList({
    super.key,
    this.sectionTitle, // now optional
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 130.0, bottom: 10),
            child: Text(
              sectionTitle!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 130.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  books.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: BookItemCard(
                        title: item['title'] as String,
                        imagePath: item['image'] as String,
                        price: item['price'] as int,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BookDetailsPage(
                                    titleText: sectionTitle ?? "",
                                    capText:
                                        'Find Your Next Great Read'
                                        '${sectionTitle != null ? " Among Our $sectionTitle." : "."}',
                                    title: item['title'] as String,
                                    imagePath: item['image'] as String,
                                    price: item['price'] as int,
                                    author: item['author'] as String,
                                    description: item['description'] as String,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
