import 'package:booknest/pages/book_details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:booknest/db/book.dart';
import 'dart:typed_data';

class CinematicCarousel extends StatelessWidget {
  const CinematicCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 355,
          color: Colors.blue,
          child: Row(
            children: [
              _buildTextSection(),
              const SizedBox(width: 95),

              Expanded(
                child: ValueListenableBuilder<Box<Book>>(
                  valueListenable: Hive.box<Book>('books').listenable(),
                  builder: (context, box, _) {
                    // Fetch, filter, and sort books for 'Cinematic Adaptation'
                    final cinematicBooks =
                        box.values.where((book) => book.category == 'cinematic').toList();

                    // Optional: Sort by title or another relevant field for consistent order
                    cinematicBooks.sort((a, b) => a.title.compareTo(b.title));

                    if (cinematicBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No cinematic adaptations found.",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }

                    return _buildMediaItems(context, cinematicBooks);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Container(
      //color: Colors.red,
      width: 400,
      alignment: Alignment.centerLeft,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.0), // Added const
          child: Column(
            children: [
              Text(
                'Cinematic',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.0), // Added const
                child: Text(
                  'Adaptation',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 60.0),
                child: Row(
                  children: [
                    Text(
                      'Start ',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      'with ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'originals',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaItems(BuildContext context, List<Book> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            books.map((book) {
              // Map directly over the Book objects

              return Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: _buildMediaItem(context, book.title, book.imageBytes, book.price, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BookDetailsPage(
                            titleText: "Cinematic Adaptation\n",
                            capText: 'Start with Originals',
                            genre: book.genre,
                            title: book.title,
                            imageBytes: book.imageBytes, // Pass Uint8List?
                            price: book.price,
                            author: book.author,
                            description: book.description,
                          ),
                    ),
                  );
                }),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildMediaItem(
    BuildContext context,
    String title,
    Uint8List? imageBytes,
    double price,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white, // Default to white
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child:
                imageBytes != null && imageBytes.isNotEmpty
                    ? Image.memory(
                      imageBytes,
                      width: 200,
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 300,
                          color: Theme.of(context).secondaryHeaderColor,
                          child: Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        );
                      },
                    )
                    : Container(
                      // Fallback for no image
                      width: 200,
                      height: 300,
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Icon(
                        Icons.movie, // Using a movie icon for cinematic theme
                        size: 80,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
          ),
          Text(
            'Rs.${price.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
