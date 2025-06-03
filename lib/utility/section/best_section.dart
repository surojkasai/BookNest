import 'package:booknest/bookslistsearch/allBooks.dart';

import 'package:booknest/pages/book_details.dart';

import 'package:booknest/utility/bookitem_card.dart';

import 'package:flutter/material.dart';

class BestSection extends StatelessWidget {
  const BestSection({super.key});

  void pushBookDetails(
    BuildContext context,

    String title,

    String imagePath,

    double price,

    String author,

    String description,
  ) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder:
            (context) => BookDetailsPage(
              title: title,

              imagePath: imagePath,

              price: price,

              titleText: "Best Selling\n",

              capText: "Find Your Next Great Read Among Our Best Selling",

              author: author,

              description: description,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Data for all your cards

    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40, top: 40),

      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Container(
                height: 100,

                padding: EdgeInsets.only(left: 20),

                alignment: Alignment.centerLeft,

                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, decoration: TextDecoration.none),

                    children: <TextSpan>[
                      TextSpan(
                        text: 'Best Selling\n',

                        style: TextStyle(
                          fontSize: 28,

                          color: Theme.of(context).textTheme.bodyLarge?.color,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: 'Find Your Next Great Read Among Our Best Selling',

                        style: TextStyle(
                          fontSize: 20,

                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
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
                        Navigator.pushNamed(context, '/bestsellers');
                      },

                      child: Text("Show all"),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Cards Row
          SizedBox(
            height: 350,

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children:
                    bestSellers.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),

                        child: BookItemCard(
                          title: item['title']! as String,

                          imagePath: item['image']! as String,

                          price: item['price']! as double,

                          onTap: () {
                            pushBookDetails(
                              context,

                              item['title']! as String,

                              item['image']! as String,

                              item['price']! as double,

                              item['author']! as String,

                              item['description']! as String,
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//new hive
// import 'package:booknest/db/book.dart'; // Import your Book model
// import 'package:booknest/pages/book_details.dart';
// import 'package:booknest/utility/bookitem_card.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder

// class BestSection extends StatelessWidget {
//   const BestSection({super.key});

//   // The pushBookDetails function needs to be updated to accept a Book object
//   // instead of individual properties, as the Book object now holds all data.
//   void pushBookDetails(
//     BuildContext context,
//     Book book, // Now pass the entire Book object
//   ) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder:
//             (context) => BookDetailsPage(
//               title: book.title,
//               //imagePath is no longer directly used, imageBytes is
//               // You'll need to pass the imageBytes or handle it in BookDetailsPage
//               // For now, let's pass null for imagePath and modify BookDetailsPage later if needed
//               imagePath: '', // This will be handled by imageBytes in BookDetailsPage
//               //imageBytes: book.imageBytes, // Pass the imageBytes
//               price: book.price,
//               titleText: "Best Selling\n",
//               capText: "Find Your Next Great Read Among Our Best Selling",
//               author: book.author,
//               description: book.description,
//             ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Instead of using a hardcoded list, use ValueListenableBuilder
//     // to listen for changes in the 'books' Hive box.
//     return ValueListenableBuilder<Box<Book>>(
//       valueListenable: Hive.box<Book>('books').listenable(),
//       builder: (context, box, _) {
//         // Filter the books to get only those in the 'Best Selling' category
//         final List<Book> bestSellers =
//             box.values.where((book) => book.category == 'Best Selling').toList();

//         // Optional: Sort them if you want a specific order (e.g., by title, or creation date)
//         // bestSellers.sort((a, b) => a.title.compareTo(b.title));

//         return Padding(
//           padding: const EdgeInsets.only(right: 40.0, left: 40, top: 40),
//           child: Column(
//             children: [
//               // Header Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                     padding: EdgeInsets.only(left: 20),
//                     alignment: Alignment.centerLeft,
//                     child: RichText(
//                       text: TextSpan(
//                         style: TextStyle(color: Colors.black, decoration: TextDecoration.none),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: 'Best Selling\n',
//                             style: TextStyle(
//                               fontSize: 28,
//                               color: Theme.of(context).textTheme.bodyLarge?.color,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'Find Your Next Great Read Among Our Best Selling',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Theme.of(context).textTheme.bodyLarge?.color,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     flex: 1,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 40.0),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/bestsellers');
//                           },
//                           child: Text("Show all"),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Cards Row
//               SizedBox(
//                 height: 350,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children:
//                         bestSellers.isEmpty
//                             ? [Center(child: Text('No best selling books found.'))]
//                             : bestSellers.map((book) {
//                               // Iterate over the fetched 'book' objects
//                               return Padding(
//                                 padding: const EdgeInsets.only(right: 20.0),
//                                 child: BookItemCard(
//                                   title: book.title,
//                                   // BookItemCard needs to handle Uint8List now instead of imagePath
//                                   imageBytes: book.imageBytes, // Pass the imageBytes
//                                   price: book.price,
//                                   onTap: () {
//                                     pushBookDetails(
//                                       context,
//                                       book, // Pass the entire book object
//                                     );
//                                   },
//                                 ),
//                               );
//                             }).toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
