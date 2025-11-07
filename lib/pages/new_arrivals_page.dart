import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:booknest/db/book.dart';

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
            Container(
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
                      text: 'New Arrivals\n',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Discover Our Latest Collections!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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

                return HorizontalBookList(books: newArrivalsBooks);
              },
            ),
          ],
        ),
      ),
      footer: footer,
    );
  }
}
