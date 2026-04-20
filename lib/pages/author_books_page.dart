import 'package:booknest/db/book.dart';
import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthorBooksPage extends StatelessWidget {
  final String authorName;
  final VoidCallback onThemeChanged;
  final Widget footer;

  const AuthorBooksPage({
    super.key,
    required this.authorName,
    required this.onThemeChanged,
    required this.footer,
  });

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
                      text: 'Books by\n',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: authorName,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            ValueListenableBuilder<Box<Book>>(
              valueListenable: Hive.box<Book>('books').listenable(),
              builder: (context, box, _) {
                // Filter books by the selected author
                final authorBooks =
                    box.values
                        .where((book) => book.author.toLowerCase() == authorName.toLowerCase())
                        .toList();

                // Sort by creation date, newest first
                authorBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                if (authorBooks.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.library_books, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            "No books found by $authorName",
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: Text(
                        '${authorBooks.length} book${authorBooks.length == 1 ? '' : 's'} available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    HorizontalBookList(books: authorBooks),
                  ],
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
