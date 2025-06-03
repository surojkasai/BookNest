import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/section/best_section.dart';
import 'package:flutter/material.dart';

class cinematicpage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final Widget footer;
  const cinematicpage({super.key, required this.onThemeChanged, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          text: 'Cinematic Adaptation\n',
                          style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Start with Originals.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //calling the bestsection to the next page
            SizedBox(height: 30),

            HorizontalBookList(
              //sectionTitle: "Editor's Picks",
              books: cinematic, // <-- A different list
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
      footer: footer,
    );
  }
}

// //new
// import 'package:booknest/newarrivallist/horizontallist.dart'; // This is your HorizontalBookList
// import 'package:booknest/pages/homepage.dart';
// import 'package:booknest/utility/section/best_section.dart'; // Not directly used here, but kept for context
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder
// import 'package:booknest/db/book.dart'; // Import your Book model

// class cinematicpage extends StatelessWidget {
//   final VoidCallback onThemeChanged;
//   final Widget footer;
//   const cinematicpage({super.key, required this.onThemeChanged, required this.footer});

//   @override
//   Widget build(BuildContext context) {
//     return Homepage(
//       onThemeChanged: onThemeChanged,
//       footer: footer,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 100,
//                   padding: EdgeInsets.only(left: 20),
//                   alignment: Alignment.centerLeft,
//                   child: RichText(
//                     text: TextSpan(
//                       style: TextStyle(
//                         color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme color
//                         decoration: TextDecoration.none,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Cinematic Adaptation\n',
//                           style: TextStyle(
//                             fontSize: 28,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Start with Originals.',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),

//             // Dynamic Book List from Hive
//             ValueListenableBuilder<Box<Book>>(
//               valueListenable: Hive.box<Book>('books').listenable(),
//               builder: (context, box, _) {
//                 // Filter books by the 'Cinematic' category
//                 final List<Book> cinematicBooks =
//                     box.values.where((book) => book.category == 'Cinematic').toList();

//                 if (cinematicBooks.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(40.0),
//                       child: Text(
//                         'No cinematic adaptation books found.',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ),
//                   );
//                 }

//                 // Pass the filtered list of Book objects to HorizontalBookList
//                 return HorizontalBookList(
//                   sectionTitle: "Cinematic Books", // Optional title for this list
//                   books: cinematicBooks, // Pass the List<Book>
//                 );
//               },
//             ),

//             SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }
