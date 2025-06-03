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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalPadding = 40.0 * 2; // 40 left + 40 right
        final spacing = 20.0 * 5; // 5 gaps between 6 items (20 px each)
        final availableWidth = screenWidth - horizontalPadding - spacing;
        final itemWidth = availableWidth / 6;

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
                    books.map((item) {
                      return SizedBox(
                        width: itemWidth,
                        height: 350,
                        child: BookItemCard(
                          title: item['title'] as String,
                          imagePath: item['image'] as String,
                          price: item['price'] as double,
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
                                      title: item['title'] as String,
                                      imagePath: item['image'] as String,
                                      price: item['price'] as double,
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
          ],
        );
      },
    );
  }
}

// //new
// import 'package:booknest/pages/book_details.dart';
// import 'package:booknest/utility/bookitem_card.dart';
// import 'package:flutter/material.dart';
// import 'package:booknest/db/book.dart'; // Import your Book model

// class HorizontalBookList extends StatelessWidget {
//   final String? sectionTitle;
//   // Change type from List<Map<String, dynamic>> to List<Book>
//   final List<Book> books;

//   const HorizontalBookList({
//     super.key,
//     this.sectionTitle, // now optional
//     required this.books,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // These calculations might need adjustment based on actual card size in BookItemCard
//         // and desired number of items per row.
//         final screenWidth = constraints.maxWidth;
//         final horizontalPadding = 40.0 * 2; // 40 left + 40 right
//         final spacing = 20.0 * 5; // 5 gaps between 6 items (20 px each)
//         final availableWidth = screenWidth - horizontalPadding - spacing;
//         // This 'itemWidth' assumes 6 items per row and may need re-evaluation
//         // based on the actual size constraints of BookItemCard.
//         // It's often better to let Wrap handle sizing unless specific fixed widths are required.
//         final itemWidth = availableWidth / 6;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (sectionTitle != null)
//               Padding(
//                 padding: const EdgeInsets.only(left: 40.0, bottom: 10),
//                 child: Text(
//                   sectionTitle!,
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     // Use theme for title
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40.0),
//               child: Wrap(
//                 spacing:
//                     20, // Increased spacing between items horizontally for better visual separation
//                 runSpacing: 20, // space between rows vertically
//                 children:
//                     books.map((book) {
//                       // Iterate over Book objects
//                       return SizedBox(
//                         // Consider removing fixed width and height here, and let BookItemCard
//                         // manage its own size or use flexbox/Expanded inside it if it's within a Row/Column.
//                         // If you keep it, ensure BookItemCard contents fit.
//                         width: itemWidth, // Re-evaluate if this fixed width is still desired
//                         height: 350, // Re-evaluate if this fixed height is still desired
//                         child: BookItemCard(
//                           title: book.title, // Access title from Book object
//                           imageBytes: book.imageBytes, // Pass imageBytes from Book object
//                           price: book.price, // Access price from Book object
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
//                                       title: book.title, // Pass title from Book object
//                                       //imagePath:'', // No longer used, but keep for compatibility if BookDetailsPage isn't fully migrated yet
//                                       imageBytes:
//                                           book.imageBytes, // Pass imageBytes from Book object
//                                       price: book.price, // Pass price from Book object
//                                       author: book.author, // Pass author from Book object
//                                       description:
//                                           book.description, // Pass description from Book object
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
