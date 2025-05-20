import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/pages/book_details.dart';
import 'package:booknest/utility/bookitem_card.dart';
import 'package:flutter/material.dart';

class NewarrivalsSection extends StatelessWidget {
  const NewarrivalsSection({super.key});
  void pushBookDetails(
    BuildContext context,
    String title,
    String imagePath,
    int price,
    String author,
    String description,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookDetailsPage(
              title: title,
              imagePath: imagePath,
              price: price,
              titleText: "New Arrivals\n",
              capText: "Find Your Next Great Read Among Our New Arrivals.",
              author: author,
              description: description,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Data for all your cards

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
                  newArrivals.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: BookItemCard(
                        title: item['title']! as String,
                        imagePath: item['image']! as String,
                        price: item['price']! as int,
                        onTap: () {
                          pushBookDetails(
                            context,
                            item['title']! as String,
                            item['image']! as String,
                            item['price']! as int,
                            item['author']! as String,
                            item['description']! as String,
                          );
                        },
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
