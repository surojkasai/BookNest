import 'package:booknest/utility/cinematic_carousel.dart';
import 'package:booknest/utility/featured/body_carousel.dart';
import 'package:booknest/utility/featured/body_item_loop.dart';
import 'package:booknest/utility/section/authors_section.dart';
import 'package:booknest/utility/section/best_section.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:booknest/utility/section/newarrivals_section.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

class Mainbody extends StatelessWidget {
  const Mainbody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //featured genres or only genres
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              //just for testing
              //color: Colors.red,
              height: 300,
              child: Scrollbar(
                thumbVisibility: true, // Makes scrollbar always visible
                interactive: true,
                child: InfiniteListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category =
                        majorcategories[index % majorcategories.length];
                    return CategoryCard(
                      title: category['title']!,
                      image: category['image']!,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          //adapted to anime,movies,web series section
          CinematicCarousel(),

          // Padding(
          //   padding: const EdgeInsets.only(right: 40, left: 60),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Container(
          //       height: 350,
          //       color: Colors.blue,
          //       child: Row(
          //         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Container(
          //             width: 400,
          //             //color: Colors.red,
          //             alignment: Alignment.centerLeft,

          /*
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Cinematic',
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                  'Adaptation',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 60.0),
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
                      Spacer(),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //first Container for Anime
                          Container(
                            //padding: EdgeInsets.only(left: 90),
                            //just for testing
                            //color: Colors.red,
                            // for flashy colours
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //     colors: [Colors.blue, Colors.purple, Colors.pink],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //   ),
                            // ),
                            //color: Colors.redAccent,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Anime',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          "assets/images/Demon_Slayer.jpg",
                                          width: 200,
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Rs.200',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 40),

                          //container for Movie
                          Container(
                            //just for testing
                            //color: Colors.blue,
                            //color: Colors.redAccent,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Movie',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/harrypotter.jpg",
                                          width: 200,
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Rs.200',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 40),

                          //Container for Game
                          Container(
                            //just for testing
                            //color: Colors.blue,
                            //color: Colors.redAccent,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Game',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/harrypotter.jpg",
                                          width: 200,
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Rs.200',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 40),

                          //container for Web-Series
                          Container(
                            padding: EdgeInsets.only(right: 35),
                            //just for testing
                            //color: Colors.blue,
                            //color: Colors.redAccent,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Web-Series',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          "assets/images/got.jpg",
                                          width: 200,
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Rs.200',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge?.color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
*/
          //Best-Selling Section
          /* Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  Row(
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
                                text: 'Best Sellers\n',
                                style: TextStyle(
                                  fontSize: 28,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Find Your Next Great Read Among Our Best Selling.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
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
                              onPressed: () {},
                              child: Text("Show all"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Best seller container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //first Container for best seller
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Anime',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/Demon_Slayer.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Movie
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Colors.red,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Movie',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/Demon_Slayer.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Movie
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          //color: Colors.redAccent,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Movie',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/harrypotter.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //Container for Game
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Colors.blue,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Game',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/the_witcher.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Web-Series
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Web-Series',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/Demon_Slayer.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Web-Series
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Colors.blue,
                          //color: Colors.redAccent,
                          height: 350,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Web-Series',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/got.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Text(
                                    'Rs.200',
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
*/
          //Best-Sellers
          BestSection(),

          //New Ariivals Section
          NewarrivalsSection(),
          /*Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  Row(
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
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Find Your Next Great Read Among Our New Arrivals.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
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
                              onPressed: () {},
                              child: Text("Show all"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Best seller container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //first Container for best seller
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Anime',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/Demon_Slayer.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Movie
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Colors.red,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Movie',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/harrypotter.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Movie
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          //color: Colors.redAccent,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Movie',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/harrypotter.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //Container for Game
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Game',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/the_witcher.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Web-Series
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //just for testing
                          //color: Colors.blue,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Web-Series',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/got.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //container for Web-Series
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          //color: Colors.blue,
                          //color: Colors.redAccent,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Web-Series',
                                  style: TextStyle(
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/images/got.jpg",
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
*/
          //SizedBox(height: 20),

          //author section
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bestselling Authors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover Books by Bestselling Authors in Our Collection, Ranked by Popularity.',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AuthorsSection(
                        name: 'Buddhisagar',
                        imagePath: 'assets/authors/buddhisagar.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Fyodor Dostoyevsky',
                        imagePath: 'assets/authors/fyodor.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Robert Greene',
                        imagePath: 'assets/authors/greene.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Sage Veda Vyasa',
                        imagePath: 'assets/authors/sage.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'A.C. Bhaktivedanta..',
                        imagePath: 'assets/authors/acb.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Colleen Hoover',
                        imagePath: 'assets/authors/colleen.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Morgan Housel',
                        imagePath: 'assets/authors/morgan.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Haruki Murakami',
                        imagePath: 'assets/authors/haruki.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        name: 'Napoleon Hill',
                        imagePath: 'assets/authors/napoleon.jpg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //footer
          //FooterSection(),
        ],
      ),
    );
  }
}
