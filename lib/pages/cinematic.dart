import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/newarrivallist/horizontallist.dart'; // This is your HorizontalBookList
import 'package:booknest/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
import 'package:booknest/db/book.dart'; // Import your Book model

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //color: Colors.red,
              height: 100,
              padding: const EdgeInsets.only(right: 40, left: 65),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    decoration: TextDecoration.none,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Cinematic\n',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Start with Originals', // Engaging subtitle
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
                final cinematicBooks =
                    box.values.where((book) => book.category == 'cinematic').toList();

                // Sort the books by creation date, newest first
                cinematicBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                if (cinematicBooks.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Text("No new arrival books found.", style: TextStyle(fontSize: 18)),
                    ),
                  );
                }

                // Pass the filtered and sorted List<Book> to HorizontalBookList
                return HorizontalBookList(
                  //sectionTitle: "Best Selling\n", // Pass the title for the list
                  books: cinematicBooks, // Pass the List<Book> fetched from Hive
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
