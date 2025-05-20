import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';

import 'package:booknest/utility/section/newarrivals_section.dart';
import 'package:flutter/material.dart';

class NewArrivalsPage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final Widget footer;
  const NewArrivalsPage({
    super.key,
    required this.onThemeChanged,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //calling the bestsection to the next page
            NewarrivalsSection(), // ✅ just add it here!
            SizedBox(height: 20),

            // Horizontal list of book items
            /* Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      newArrivals.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: BookItemCard(
                            title: item['title']! as String,
                            imagePath: item['image']! as String,
                            price: item['price']! as int,
                            onTap: () {
                              print("Tapped: ${item['title']}");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookDetailsPage(
                                        titleText: "Best Selling\n",
                                        capText:
                                            'Find Your Next Great Read Among Our Best Selling.',
                                        title: item['title']! as String,
                                        imagePath: item['image']! as String,
                                        price: item['price']! as int,
                                        author: 'James',
                                        // onThemeChanged: onThemeChanged,
                                        // footer: footer,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      newArrivals.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: BookItemCard(
                            title: item['title']! as String,
                            imagePath: item['image']! as String,
                            price: item['price']! as int,
                            onTap: () {
                              print("Tapped: ${item['title']}");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookDetailsPage(
                                        titleText: "Best Selling\n",
                                        capText:
                                            'Find Your Next Great Read Among Our Best Selling.',
                                        title: item['title']! as String,
                                        imagePath: item['image']! as String,
                                        price: item['price']! as int,
                                        author: 'James',
                                        // onThemeChanged: onThemeChanged,
                                        // footer: footer,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
*/
            HorizontalBookList(
              //sectionTitle: "Editor's Picks",
              books: editorsPickList, // <-- A different list
            ),
            HorizontalBookList(
              //sectionTitle: "New Arrivals",
              books: newArrivals,
            ),

            SizedBox(height: 30),

            // Now add your section(s) below
            //Section(), // You can repeat as needed
            //SizedBox(height: 30),
          ],
        ),
      ),

      footer: footer,
    );
  }
}
