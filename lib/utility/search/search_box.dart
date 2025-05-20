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
                                      author: 'Unknown',
                                      description: 'hello',
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    );
  }
}
