import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/bookitem_card.dart';

import 'package:booknest/utility/section/footer_section.dart';
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
    final newArrivals = [
      {
        'title': 'Anime',
        'image': 'assets/images/Demon_Slayer.jpg',
        'price': 'Rs.200',
      },
      {
        'title': 'Movie',
        'image': 'assets/images/Demon_Slayer.jpg',
        'price': 'Rs.200',
      },
      {
        'title': 'Movie',
        'image': 'assets/images/harrypotter.jpg',
        'price': 'Rs.200',
      },
      {
        'title': 'Game',
        'image': 'assets/images/the_witcher.jpg',
        'price': 'Rs.200',
      },
      {
        'title': 'Web-Series',
        'image': 'assets/images/Demon_Slayer.jpg',
        'price': 'Rs.200',
      },
      {
        'title': 'Web-Series',
        'image': 'assets/images/got.jpg',
        'price': 'Rs.200',
      },
    ];
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
                            title: item['title']!,
                            imagePath: item['image']!,
                            price: item['price']!,
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
                            title: item['title']!,
                            imagePath: item['image']!,
                            price: item['price']!,
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
                            title: item['title']!,
                            imagePath: item['image']!,
                            price: item['price']!,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),

            // Now add your section(s) below
            //Section(), // You can repeat as needed
            SizedBox(height: 30),
          ],
        ),
      ),

      footer: footer,
    );
  }
}
