import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
import 'package:booknest/db/book.dart'; // Assuming your Book model is here
import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';

class BestSection extends StatelessWidget {
  const BestSection({super.key});

  void pushBookDetails(
    BuildContext context,
    String title,
    Uint8List? imageBytes,
    double price,
    String author,
    String description,
    //String category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookDetailsPage(
              title: title,
              imageBytes: imageBytes,
              price: price,
              titleText: "Best Selling\n",
              capText: "Find Your Next Great Read Among Our Best SELLING",
              author: author,
              description: description,
              //category: category,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, left: 40, top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  //color: Colors.red,
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        decoration: TextDecoration.none,
                      ),
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
                      child: Text(
                        "Show all",
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- CRITICAL CHANGE: Hive Integration within the existing layout ---
          // Cards Row
          SizedBox(
            height: 350,
            child: ValueListenableBuilder<Box<Book>>(
              // Wrapped the content here
              valueListenable:
                  Hive.box<Book>('books').listenable(), // Listen to your 'books' Hive box
              builder: (context, box, child) {
                // Fetch, filter, and sort books from Hive
                final bestSellerBook =
                    box.values.where((book) => book.category == 'Best Selling').toList();
                //the category name is what decides the book
                // Sort by creation date (newest first)
                //newArrivalsBooks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                // If no books are found, display a message
                if (bestSellerBook.isEmpty) {
                  return const Center(
                    child: Text("No best selling found in Hive.", style: TextStyle(fontSize: 18)),
                  );
                }

                // If books are found, render them using the existing SingleChildScrollView and Row
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        bestSellerBook.map((book) {
                          // Iterate over the Book objects
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SizedBox(
                              width: 220, // Consistent width for each card
                              height: 350, // Consistent height for each card
                              child: BookItemCard(
                                title: book.title, // Access title directly from Book object
                                imageBytes:
                                    book.imageBytes, // Access imageBytes directly from Book object
                                price: book.price, // Access price directly from Book object
                                onTap: () {
                                  pushBookDetails(
                                    context,
                                    book.title,
                                    book.imageBytes,
                                    book.price,
                                    book.author,
                                    book.description,
                                    //book.category, // Pass category
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
