import 'package:booknest/pages/book_details.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import for Hive
import 'package:booknest/db/book.dart'; // Assuming your Book model is here
import 'dart:typed_data'; // Required for Uint8List

class CinematicCarousel extends StatelessWidget {
  const CinematicCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // cinematiclist is no longer needed here as data will come from Hive
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 355,
          color:
              Colors
                  .blue, // Consider using Theme.of(context).colorScheme.primaryContainer or similar for theming
          child: Row(
            children: [
              _buildTextSection(),
              //const Spacer(),
              const SizedBox(width: 95),
              // --- CRITICAL CHANGE: Hive Integration within the existing layout ---
              // Wrap the media items section with ValueListenableBuilder
              Expanded(
                // Ensure this Expanded is here to give _buildMediaItems space
                child: ValueListenableBuilder<Box<Book>>(
                  valueListenable:
                      Hive.box<Book>('books').listenable(), // Listen to your 'books' Hive box
                  builder: (context, box, _) {
                    // Fetch, filter, and sort books for 'Cinematic Adaptation'
                    final cinematicBooks =
                        box.values
                            .where(
                              (book) => book.category == 'cinematic',
                            ) // Assuming a 'Cinematic Adaptation' category
                            .toList();

                    // Optional: Sort by title or another relevant field for consistent order
                    cinematicBooks.sort((a, b) => a.title.compareTo(b.title));

                    if (cinematicBooks.isEmpty) {
                      return const Center(
                        child: Text(
                          "No cinematic adaptations found.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ), // Adjust text color for visibility
                        ),
                      );
                    }

                    // Pass the filtered books to the _buildMediaItems function
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
        // Added const
        child: Padding(
          padding: EdgeInsets.only(top: 40.0), // Added const
          child: Column(
            children: [
              Text(
                'Cinematic',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), // Added color for visibility
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.0), // Added const
                child: Text(
                  'Adaptation',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              SizedBox(height: 10), // Added const
              Padding(
                padding: EdgeInsets.only(left: 60.0), // Added const
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
                      ), // Added color for visibility
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

  // Modified: _buildMediaItems now takes a List<Book>
  Widget _buildMediaItems(BuildContext context, List<Book> books) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            books.map((book) {
              // Map directly over the Book objects
              // Assuming each book object has title, imageBytes, price, author, description, category
              return Padding(
                padding: const EdgeInsets.only(right: 40.0), // Added const
                child: _buildMediaItem(
                  context,
                  book.title,
                  book.imageBytes, // Pass Uint8List?
                  book.price,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BookDetailsPage(
                              titleText: "Cinematic Adaptation\n",
                              capText: 'Start with Originals',
                              title: book.title,
                              imageBytes: book.imageBytes, // Pass Uint8List?
                              price: book.price,
                              author: book.author,
                              description: book.description,
                              //category: book.category, // Pass category from the Book object
                            ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
      ),
    );
  }

  // Modified: _buildMediaItem now accepts Uint8List? for image
  Widget _buildMediaItem(
    BuildContext context,
    String title,
    Uint8List? imageBytes, // Changed to Uint8List?
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
            'Rs.${price.toStringAsFixed(2)}', // Format price to 2 decimal places
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white, // Default to white
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
