// import 'package:booknest/pages/book_details.dart';
// import 'package:booknest/utility/bookitem_card.dart';
// import 'package:flutter/material.dart';

// class HorizontalBookList extends StatelessWidget {
//   final String? sectionTitle;
//   final List<Map<String, dynamic>> books;

//   const HorizontalBookList({
//     super.key,
//     this.sectionTitle, // now optional
//     required this.books,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final horizontalPadding = 40.0 * 2; // 40 left + 40 right
//         final spacing = 20.0 * 5; // 5 gaps between 6 items (20 px each)
//         final availableWidth = screenWidth - horizontalPadding - spacing;
//         final itemWidth = availableWidth / 6;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (sectionTitle != null)
//               Padding(
//                 padding: const EdgeInsets.only(left: 40.0, bottom: 10),
//                 child: Text(
//                   sectionTitle!,
//                   style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40.0),
//               child: Wrap(
//                 spacing: 10, // space between items horizontally
//                 runSpacing: 20, // space between rows vertically
//                 children:
//                     books.map((item) {
//                       return SizedBox(
//                         width: itemWidth,
//                         height: 350,
//                         child: BookItemCard(
//                           title: item['title'] as String,
//                           imagePath: item['image'] as String,
//                           price: item['price'] as double,
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => BookDetailsPage(
//                                       titleText: sectionTitle ?? "",
//                                       capText:
//                                           'Find Your Next Great Read'
//                                           '${sectionTitle != null ? " Among Our $sectionTitle" : ""}',
//                                       title: book.title,
//                                       //item['title'] as String,
//                                       //imagePath: item['image'] as String,
//                                       imageBytes: book.imageBytes,
//                                       price: book.price,
//                                       //item['price'] as double,
//                                       author: book.author,
//                                       //item['author'] as String,
//                                       description: book.description,
//                                       //item['description'] as String,
//                                     ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }).toList(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//new
import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';
import 'package:flutter/material.dart';
import 'package:booknest/db/book.dart'; // Import your Book model
import 'dart:typed_data'; // Required for Uint8List

class HorizontalBookList extends StatelessWidget {
  final String? sectionTitle;
  // CRITICAL CHANGE: The 'books' list now accepts a List<Book> directly
  final List<Book> books; // Changed type from List<Map<String, dynamic>>

  const HorizontalBookList({
    super.key,
    this.sectionTitle, // now optional
    required this.books, // Now expects List<Book>
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalPadding = 40.0 * 2; // 40 left + 40 right
        // The current spacing calculation assumes 6 items with 5 gaps.
        // If the number of items can vary, this calculation might need adjustment,
        // or a simpler `Wrap` spacing might be preferred without pre-calculating `itemWidth`.
        final spacing =
            10.0 * (books.length - 1).clamp(0, double.infinity); // Use actual spacing from Wrap
        final availableWidth = screenWidth - horizontalPadding;
        // Adjust itemWidth calculation to use Wrap's spacing property directly
        // The `Wrap` widget handles item placement, so pre-calculating a fixed `itemWidth` based on 6 items
        // and then passing it might lead to non-uniform spacing if the actual number of items changes.
        // For consistency with Wrap, let's target a reasonable default width or allow Wrap to manage.
        // Keeping your calculation for now, but note the interaction with `Wrap`'s `spacing`.
        final itemWidth =
            (availableWidth - spacing) / 6; // Adjusted to be more accurate with Wrap's spacing

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
                spacing: 10, // space between items horizontally
                runSpacing: 20, // space between rows vertically
                children:
                    // CRITICAL CHANGE: Map directly over Book objects
                    books.map((book) {
                      // 'book' is now a Book object
                      return SizedBox(
                        width: itemWidth, // Uses the calculated width
                        height: 350,
                        child: BookItemCard(
                          title: book.title, // Access title directly from Book object
                          imageBytes:
                              book.imageBytes, // Access imageBytes directly from Book object
                          price: book.price, // Access price directly from Book object
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
                                      title: book.title, // Pass title from Book object
                                      imageBytes:
                                          book.imageBytes, // Pass imageBytes from Book object
                                      price: book.price, // Pass price from Book object
                                      author: book.author, // Pass author from Book object
                                      description:
                                          book.description, // Pass description from Book object
                                      //category: book.category, // Pass category from Book object
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
