import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/newarrivallist/horizontallist.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/section/best_section.dart';
import 'package:flutter/material.dart';

class bestSellersPage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final Widget footer;
  const bestSellersPage({
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
            BestSection(),
            SizedBox(height: 20),

            SizedBox(height: 30),

            /*Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      bestSellers.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: BookItemCard(
                            title: item['title']! as String,
                            imagePath: item['image']! as String,
                            price: item['price']! as int,
                            onTap: () {
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
              books: bestSellers, // <-- A different list
            ),
            // Now add your section(s) below
            //Section(), // You can repeat as needed
            SizedBox(height: 30),
            HorizontalBookList(
              //sectionTitle: "Editor's Picks",
              books: editorsPickList, // <-- A different list
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
      footer: footer,
    );
  }
}
