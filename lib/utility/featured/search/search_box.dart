import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/db/book.dart';
import 'package:booknest/pages/book_details.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchDialogue extends StatefulWidget {
  const SearchDialogue({super.key});

  @override
  State<SearchDialogue> createState() => _SearchDialogueState();
}

class _SearchDialogueState extends State<SearchDialogue> {
  String query = '';
  //List<Map<String, dynamic>> results = [];
  List<Book> results = []; // Change from Map<String, dynamic> to Book

  // void updateResults(String input) {
  //   setState(() {
  //     query = input; // update the query first ✅
  //     results =
  //         allBooks.where((book) {
  //           final title = book['title'] as String;
  //           return title.toLowerCase().contains(query.toLowerCase());
  //         }).toList();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Initially, display all books when the dialogue opens
    final bookBox = Hive.box<Book>('books');
    results = bookBox.values.toList();
  }

  void updateResults(String input) {
    setState(() {
      query = input;
      final bookBox = Hive.box<Book>('books'); // Get the Hive box instance

      if (query.isEmpty) {
        // If the search query is empty, show all books
        results = bookBox.values.toList();
      } else {
        // Filter books by title (case-insensitive)
        results =
            bookBox.values
                .where(
                  (book) =>
                      book.title.toLowerCase().contains(query.toLowerCase()) ||
                      book.author.toLowerCase().contains(query.toLowerCase()),
                ) // Also search by author
                .toList();
      }
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
                          leading:
                              book.imageBytes != null && book.imageBytes!.isNotEmpty
                                  ? Image.memory(
                                    book.imageBytes!,
                                    //height: 300,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  )
                                  : Container(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    child: Icon(
                                      Icons.book,
                                      size: 80,
                                      color: Theme.of(context).colorScheme.onSecondary,
                                    ),
                                  ),
                          //Image.asset(book['image'], width: 40),
                          title: Text(book.title),
                          //Text(book['title']),
                          subtitle: Text("${book.author}"),
                          //Text("Rs. ${book['price']}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => BookDetailsPage(
                                      titleText: "Search Result\n",
                                      capText: 'Book you searched for.',
                                      title: book.title,
                                      //book['title'],
                                      //imagePath: book['image'],
                                      price: book.price,
                                      //book['price'],
                                      author: book.author,
                                      //book['author'],
                                      description: book.description,
                                      //book['description'],
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
