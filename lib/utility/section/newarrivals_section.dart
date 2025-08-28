// import 'package:booknest/bookslistsearch/allBooks.dart';
// import 'package:booknest/pages/book_details.dart';
// import 'package:booknest/utility/bookitem_card.dart';
// import 'package:flutter/material.dart';

// class NewarrivalsSection extends StatelessWidget {
//   const NewarrivalsSection({super.key});
//   void pushBookDetails(
//     BuildContext context,
//     String title,
//     String imagePath,
//     double price,
//     String author,
//     String description,
//   ) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder:
//             (context) => BookDetailsPage(
//               title: title,
//               imagePath: imagePath,
//               price: price,
//               titleText: "New Arrivals\n",
//               capText: "Find Your Next Great Read Among Our New Arrivals",
//               author: author,
//               description: description,
//             ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Data for all your cards

//     return Padding(
//       padding: const EdgeInsets.all(40.0),
//       child: Column(
//         children: [
//           // Header Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 height: 100,
//                 padding: EdgeInsets.only(left: 20),
//                 alignment: Alignment.centerLeft,
//                 child: RichText(
//                   text: TextSpan(
//                     style: TextStyle(color: Colors.black, decoration: TextDecoration.none),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: 'New Arrivals\n',
//                         style: TextStyle(
//                           fontSize: 28,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Find Your Next Great Read Among Our New Arrivals',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 40.0),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/newarrivals');
//                       },
//                       child: Text("Show all"),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Cards Row
//           SizedBox(
//             height: 350,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children:
//                     newArrivals.map((item) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 20.0),
//                         child: BookItemCard(
//                           title: item['title']! as String,
//                           imagePath: item['image']! as String,
//                           price: item['price']! as double,
//                           onTap: () {
//                             pushBookDetails(
//                               context,
//                               item['title']! as String,
//                               item['image']! as String,
//                               item['price']! as double,
//                               item['author']! as String,
//                               item['description']! as String,
//                             );
//                           },
//                         ),
//                       );
//                     }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // //new

// // import 'package:booknest/bookslistsearch/allBooks.dart'; // Still potentially useful if allBooks needs to be a separate page data source
// // import 'package:booknest/pages/book_details.dart';
// // import 'package:booknest/utility/bookitem_card.dart';
// // import 'package:flutter/material.dart';
// // import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder
// // import 'package:booknest/db/book.dart'; // Import your Book model
// // import 'dart:typed_data'; // For Uint8List

// // class NewarrivalsSection extends StatelessWidget {
// //   const NewarrivalsSection({super.key});

// //   // Updated pushBookDetails to accept a Book object
// //   void _pushBookDetails(
// //     BuildContext context,
// //     Book book, // Pass the entire Book object
// //   ) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder:
// //             (context) => BookDetailsPage(
// //               title: book.title,
// //               // imagePath is no longer directly used, imageBytes is
// //               //imagePath: '', // This will be ignored now by BookDetailsPage
// //               imageBytes: book.imageBytes, // Pass the imageBytes
// //               price: book.price,
// //               titleText: "New Arrivals\n",
// //               capText: "Find Your Next Great Read Among Our New Arrivals",
// //               author: book.author,
// //               description: book.description,
// //             ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(40.0),
// //       child: Column(
// //         children: [
// //           // Header Row
// //           Row(
// //             mainAxisAlignment:
// //                 MainAxisAlignment.spaceBetween, // Use spaceBetween for cleaner layout
// //             children: [
// //               Expanded(
// //                 // Wrap RichText in Expanded to give it flexible space
// //                 flex: 3,
// //                 child: Container(
// //                   height: 100,
// //                   alignment: Alignment.centerLeft,
// //                   child: RichText(
// //                     text: TextSpan(
// //                       style: TextStyle(
// //                         color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme color
// //                         decoration: TextDecoration.none,
// //                       ),
// //                       children: <TextSpan>[
// //                         TextSpan(
// //                           text: 'New Arrivals\n',
// //                           style: TextStyle(
// //                             fontSize: 28,
// //                             color: Theme.of(context).textTheme.bodyLarge?.color,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: 'Find Your Next Great Read Among Our New Arrivals',
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             color: Theme.of(context).textTheme.bodyLarge?.color,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 // Wrap TextButton in Expanded
// //                 flex: 1,
// //                 child: Align(
// //                   alignment: Alignment.centerRight,
// //                   child: TextButton(
// //                     onPressed: () {
// //                       Navigator.pushNamed(context, '/newarrivals');
// //                     },
// //                     style: TextButton.styleFrom(
// //                       foregroundColor: Theme.of(context).colorScheme.primary, // Button text color
// //                     ),
// //                     child: const Text(
// //                       "Show all",
// //                       style: TextStyle(fontSize: 18), // Adjust font size for readability
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),

// //           // Cards Row - Now dynamic from Hive
// //           SizedBox(
// //             height: 350, // Fixed height for the horizontal scroll view
// //             child: ValueListenableBuilder<Box<Book>>(
// //               valueListenable: Hive.box<Book>('books').listenable(),
// //               builder: (context, box, _) {
// //                 // Filter books for the 'New Arrivals' category or by some 'isNew' flag
// //                 // For demonstration, let's assume a 'New Arrivals' category or simply take recent additions
// //                 final List<Book> newArrivalsBooks =
// //                     box.values
// //                         .where(
// //                           (book) => book.category == 'New Arrivals',
// //                         ) // Filter by a 'New Arrivals' category
// //                         .toList();

// //                 // Optional: You might want to sort them by date added or other criteria
// //                 // newArrivalsBooks.sort((a, b) => b.addedDate.compareTo(a.addedDate));

// //                 // Take a limited number of books for the section display
// //                 final List<Book> displayBooks = newArrivalsBooks.take(5).toList(); // Show top 5

// //                 if (displayBooks.isEmpty) {
// //                   return Center(
// //                     child: Text(
// //                       'No new arrivals found.',
// //                       style: Theme.of(context).textTheme.bodyMedium,
// //                     ),
// //                   );
// //                 }

// //                 return SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //                   child: Row(
// //                     children:
// //                         displayBooks.map((book) {
// //                           return Padding(
// //                             padding: const EdgeInsets.only(right: 20.0),
// //                             child: BookItemCard(
// //                               title: book.title,
// //                               imageBytes: book.imageBytes, // Pass imageBytes
// //                               price: book.price,
// //                               onTap: () {
// //                                 _pushBookDetails(context, book); // Pass the whole book object
// //                               },
// //                             ),
// //                           );
// //                         }).toList(),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

//new
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
import 'package:booknest/db/book.dart'; // Assuming your Book model is here
import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';

class NewarrivalsSection extends StatelessWidget {
  const NewarrivalsSection({super.key});

  void pushBookDetails(
    BuildContext context,
    String title,
    Uint8List? imageBytes,
    double price,
    String author,
    String description,
    //String category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookDetailsPage(
              title: title,
              imageBytes: imageBytes,
              price: price,
              titleText: "New Arrivals\n",
              capText: "Find Your Next Great Read Among Our New Arrivals",
              author: author,
              description: description,
              //category: category,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40, top: 40),
      child: Column(
        children: [
          // Header Row - No structural changes here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  //color: Colors.blue,
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        decoration: TextDecoration.none,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'New Arrivals\n',
                          style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Find Your Next Great Read Among Our New Arrivals',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/newarrivals');
                      },
                      child: Text(
                        "Show all",
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- CRITICAL CHANGE: Hive Integration within the existing layout ---
          // Cards Row
          SizedBox(
            height: 350,
            child: ValueListenableBuilder<Box<Book>>(
              // Wrapped the content here
              valueListenable:
                  Hive.box<Book>('books').listenable(), // Listen to your 'books' Hive box
              builder: (context, box, child) {
                // Fetch, filter, and sort books from Hive
                final newArrivalsBooks =
                    box.values.where((book) => book.category == 'New Arrivals').toList();
                // Sort by creation date (newest first)
                newArrivalsBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                // If no books are found, display a message
                if (newArrivalsBooks.isEmpty) {
                  return const Center(
                    child: Text("No new arrivals found in Hive.", style: TextStyle(fontSize: 18)),
                  );
                }

                // If books are found, render them using the existing SingleChildScrollView and Row
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        newArrivalsBooks.map((book) {
                          // Iterate over the Book objects
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              width: 220, // Consistent width for each card
                              height: 350, // Consistent height for each card
                              child: BookItemCard(
                                title: book.title, // Access title directly from Book object
                                imageBytes:
                                    book.imageBytes, // Access imageBytes directly from Book object
                                price: book.price, // Access price directly from Book object
                                onTap: () {
                                  pushBookDetails(
                                    context,
                                    book.title,
                                    book.imageBytes,
                                    book.price,
                                    book.author,
                                    book.description,
                                    //book.category, // Pass category
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
