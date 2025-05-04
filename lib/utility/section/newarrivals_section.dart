import 'package:booknest/main.dart';
import 'package:booknest/pages/new_arrivals_page.dart';
import 'package:booknest/utility/bookitem_card.dart';
import 'package:flutter/material.dart';

class NewarrivalsSection extends StatelessWidget {
  const NewarrivalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for all your cards
    final bestSellers = [
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

    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
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
                        text:
                            'Find Your Next Great Read Among Our New Arrivals.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
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
                        Navigator.pushNamed(context, '/newarrivals');
                      },
                      child: Text("Show all"),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Cards Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  bestSellers.map((item) {
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
        ],
      ),
    );
  }
}
