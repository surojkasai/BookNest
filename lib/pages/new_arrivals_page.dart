//working
// import 'package:booknest/bookslistsearch/allBooks.dart';
// import 'package:booknest/newarrivallist/horizontallist.dart';
// import 'package:booknest/pages/homepage.dart';

// import 'package:booknest/utility/section/newarrivals_section.dart';
// import 'package:flutter/material.dart';

// class NewArrivalsPage extends StatelessWidget {
//   final VoidCallback onThemeChanged;
//   final Widget footer;
//   const NewArrivalsPage({super.key, required this.onThemeChanged, required this.footer});

//   @override
//   Widget build(BuildContext context) {
//     return Homepage(
//       onThemeChanged: onThemeChanged,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             HorizontalBookList(
//               sectionTitle: "New Arrival's\n",
//               books: newArrivals, // <-- A different list
//             ),
//           ],
//         ),
//       ),

//       footer: footer,
//     );
//   }
// }

//new
// import 'package:booknest/newarrivallist/horizontallist.dart';
// import 'package:booknest/pages/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder
// import 'package:booknest/db/book.dart'; // Import your Book model

// class NewArrivalsPage extends StatelessWidget {
//   final VoidCallback onThemeChanged;
//   final Widget footer;
//   const NewArrivalsPage({super.key, required this.onThemeChanged, required this.footer});

//   @override
//   Widget build(BuildContext context) {
//     return Homepage(
//       onThemeChanged: onThemeChanged,
//       footer: footer,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header for New Arrivals section
//             Container(
//               height: 100,
//               padding: EdgeInsets.only(left: 40), // Consistent padding
//               alignment: Alignment.centerLeft,
//               child: RichText(
//                 text: TextSpan(
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.bodyLarge?.color,
//                     decoration: TextDecoration.none,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'New Arrivals\n',
//                       style: TextStyle(
//                         fontSize: 28,
//                         color: Theme.of(context).textTheme.bodyLarge?.color,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Discover Our Latest Collections!', // Engaging subtitle
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Theme.of(context).textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30), // Spacing after header
//             // Dynamic Book List from Hive for New Arrivals
//             ValueListenableBuilder<Box<Book>>(
//               valueListenable: Hive.box<Book>('books').listenable(),
//               builder: (context, box, _) {
//                 // Filter books by the 'New Arrivals' category
//                 final List<Book> newArrivalsBooks =
//                     box.values.where((book) => book.category == 'New Arrivals').toList();

//                 // Optional: You might want to sort them by createdAt date for true "new arrivals"
//                 newArrivalsBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

//                 if (newArrivalsBooks.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(40.0),
//                       child: Text(
//                         'No new arrival books found.',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ),
//                   );
//                 }

//                 // Pass the filtered and potentially sorted list of Book objects to HorizontalBookList
//                 return HorizontalBookList(
//                   sectionTitle: "New Arrivals", // Pass the title for the list
//                   books: newArrivalsBooks, // Pass the List<Book>
//                 );
//               },
//             ),

//             const SizedBox(height: 30), // Spacing before footer
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:booknest/newarrivallist/horizontallist.dart'; // This is your HorizontalBookList
import 'package:booknest/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
import 'package:booknest/db/book.dart'; // Import your Book model

class NewArrivalsPage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final Widget footer;

  const NewArrivalsPage({super.key, required this.onThemeChanged, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header for New Arrivals section (Optional, but good for consistency)
            Container(
              height: 100,
              padding: const EdgeInsets.only(right: 40, left: 65), // Consistent padding
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
                      text: 'Discover Our Latest Collections!', // Engaging subtitle
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30), // Spacing after header
            // --- CRITICAL CHANGE: Hive Integration ---
            // Use ValueListenableBuilder to fetch and display new arrival books from Hive
            ValueListenableBuilder<Box<Book>>(
              valueListenable:
                  Hive.box<Book>('books').listenable(), // Listen to your 'books' Hive box
              builder: (context, box, _) {
                // Fetch and filter books that are marked as 'New Arrivals'
                final newArrivalsBooks =
                    box.values.where((book) => book.category == 'New Arrivals').toList();

                // Sort the books by creation date, newest first
                newArrivalsBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                if (newArrivalsBooks.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Text("No new arrival books found.", style: TextStyle(fontSize: 18)),
                    ),
                  );
                }

                // Pass the filtered and sorted List<Book> to HorizontalBookList
                return HorizontalBookList(
                  //sectionTitle: "New Arrivals\n", // Pass the title for the list
                  books: newArrivalsBooks, // Pass the List<Book> fetched from Hive
                );
              },
            ),
          ],
        ),
      ),
      footer: footer,
    );
  }
}
