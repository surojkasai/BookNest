import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:flutter/material.dart';

class bestSellersPage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final Widget footer;
  const bestSellersPage({super.key, required this.onThemeChanged, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //calling the bestsection to the next page
            HorizontalBookList(sectionTitle: "Best Selling\n", books: bestSellers),

            //books: getBooksByCategory("Best Selling"),
          ],
        ),
      ),
      footer: footer,
    );
  }
}

// //new
// import 'package:booknest/newarrivallist/horizontallist.dart';
// import 'package:booknest/pages/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder
// import 'package:booknest/db/book.dart'; // Import your Book model

// class bestSellersPage extends StatelessWidget {
//   final VoidCallback onThemeChanged;
//   final Widget footer;
//   const bestSellersPage({super.key, required this.onThemeChanged, required this.footer});

//   @override
//   Widget build(BuildContext context) {
//     return Homepage(
//       onThemeChanged: onThemeChanged,
//       footer: footer,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header for Best Selling section
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
//                       text: 'Best Selling\n',
//                       style: TextStyle(
//                         fontSize: 28,
//                         color: Theme.of(context).textTheme.bodyLarge?.color,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Discover Our Top Reads!', // A more engaging subtitle
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
//             // Dynamic Book List from Hive for Best Selling
//             ValueListenableBuilder<Box<Book>>(
//               valueListenable: Hive.box<Book>('books').listenable(),
//               builder: (context, box, _) {
//                 // Filter books by the 'Best Selling' category
//                 final List<Book> bestSellingBooks =
//                     box.values.where((book) => book.category == 'Best Selling').toList();

//                 if (bestSellingBooks.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(40.0),
//                       child: Text(
//                         'No best-selling books found.',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ),
//                   );
//                 }

//                 // Pass the filtered list of Book objects to HorizontalBookList
//                 return HorizontalBookList(
//                   sectionTitle: "Best Selling", // Pass the title for the list
//                   books: bestSellingBooks, // Pass the List<Book>
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
