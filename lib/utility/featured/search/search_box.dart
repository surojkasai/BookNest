import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/pages/book_details.dart';
import 'package:flutter/material.dart';

class SearchDialogue extends StatefulWidget {
  const SearchDialogue({super.key});

  @override
  State<SearchDialogue> createState() => _SearchDialogueState();
}

class _SearchDialogueState extends State<SearchDialogue> {
  String query = '';
  List<Map<String, dynamic>> results = [];

  void updateResults(String input) {
    setState(() {
      query = input; // update the query first ✅
      results =
          allBooks.where((book) {
            final title = book['title'] as String;
            return title.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Search Books"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter book title"),
            onChanged: updateResults,
          ),
          SizedBox(height: 10),
          Container(
            width: 500,
            height: 250,
            child:
                results.isEmpty
                    ? Text("No results")
                    : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final book = results[index];
                        return ListTile(
                          leading: Image.asset(book['image'], width: 40),
                          title: Text(book['title']),
                          subtitle: Text("Rs. ${book['price']}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => BookDetailsPage(
                                      titleText: "Search Result\n",
                                      capText: 'Book you searched for.',
                                      title: book['title'],
                                      imagePath: book['image'],
                                      price: book['price'],
                                      author: book['author'],
                                      description: book['description'],
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Close"))],
    );
  }
}

// //new
// import 'package:booknest/pages/book_details.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
// import 'package:booknest/db/book.dart'; // Import your Book model
// import 'dart:typed_data'; // Import for Uint8List

// class SearchDialogue extends StatefulWidget {
//   const SearchDialogue({super.key});

//   @override
//   State<SearchDialogue> createState() => _SearchDialogueState();
// }

// class _SearchDialogueState extends State<SearchDialogue> {
//   String query = '';
//   List<Book> results = []; // Change from Map<String, dynamic> to Book

//   @override
//   void initState() {
//     super.initState();
//     // Initially, display all books when the dialogue opens
//     final bookBox = Hive.box<Book>('books');
//     results = bookBox.values.toList();
//   }

//   void updateResults(String input) {
//     setState(() {
//       query = input;
//       final bookBox = Hive.box<Book>('books'); // Get the Hive box instance

//       if (query.isEmpty) {
//         // If the search query is empty, show all books
//         results = bookBox.values.toList();
//       } else {
//         // Filter books by title (case-insensitive)
//         results =
//             bookBox.values
//                 .where(
//                   (book) =>
//                       book.title.toLowerCase().contains(query.toLowerCase()) ||
//                       book.author.toLowerCase().contains(query.toLowerCase()),
//                 ) // Also search by author
//                 .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Search Books"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min, // Keep content compact
//         children: [
//           TextField(
//             autofocus: true,
//             decoration: const InputDecoration(
//               hintText: "Enter book title or author", // Updated hint text
//               border: OutlineInputBorder(), // Add a border for better appearance
//               prefixIcon: Icon(Icons.search), // Add a search icon
//             ),
//             onChanged: updateResults,
//           ),
//           const SizedBox(height: 10),
//           // Use ValueListenableBuilder if you want search results to update
//           // in real-time even if Hive data changes *while the dialog is open*.
//           // Otherwise, the current approach of fetching on `initState` and `onChanged` is fine.
//           // For a search dialog, `onChanged` is usually sufficient as the user is actively typing.

//           // Using a ConstrainedBox for fixed height, or Expanded within a flexible parent
//           // if this AlertDialog is inside a larger layout that provides constraints.
//           // Since it's AlertDialog content, mainAxisSize.min is appropriate,
//           // but a fixed height for the list view is good here.
//           Container(
//             width: 500, // Fixed width for the dialog content
//             height: 250, // Fixed height for the search results list
//             child:
//                 results.isEmpty
//                     ? Center(
//                       // Center the "No results" text
//                       child: Text(
//                         query.isEmpty ? "Start typing to search..." : "No results found.",
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     )
//                     : ListView.builder(
//                       itemCount: results.length,
//                       itemBuilder: (context, index) {
//                         final book = results[index]; // `book` is now a `Book` object

//                         return ListTile(
//                           leading:
//                               book.imageBytes != null && book.imageBytes!.isNotEmpty
//                                   ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(
//                                       4.0,
//                                     ), // Slightly rounded corners for image
//                                     child: Image.memory(
//                                       book.imageBytes!,
//                                       width: 40,
//                                       height: 60, // Give some height for consistent sizing
//                                       fit: BoxFit.cover, // Cover the box
//                                     ),
//                                   )
//                                   : Container(
//                                     // Placeholder if no imageBytes
//                                     width: 40,
//                                     height: 60,
//                                     color: Theme.of(context).secondaryHeaderColor,
//                                     child: Icon(
//                                       Icons.book,
//                                       size: 30,
//                                       color: Theme.of(context).colorScheme.onSecondary,
//                                     ),
//                                   ),
//                           title: Text(book.title),
//                           subtitle: Text(
//                             "${book.author} - Rs. ${book.price.toStringAsFixed(2)}",
//                           ), // Display author and price
//                           onTap: () {
//                             // Close the search dialog and navigate to BookDetailsPage
//                             Navigator.pop(context); // Pop the AlertDialog first
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (_) => BookDetailsPage(
//                                       titleText: "Search Result\n",
//                                       capText: 'Book you searched for.',
//                                       title: book.title,
//                                       //imagePath: '', // This will be ignored now by BookDetailsPage
//                                       imageBytes: book.imageBytes, // Pass the Uint8List
//                                       price: book.price,
//                                       author: book.author,
//                                       description: book.description,
//                                     ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//           ),
//         ],
//       ),
//       actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
//     );
//   }
// }
