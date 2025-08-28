import 'package:booknest/utility/cinematic_carousel.dart';
import 'package:booknest/utility/featured/body_carousel.dart';
import 'package:booknest/utility/featured/body_item_loop.dart';
import 'package:booknest/utility/section/authors_section.dart';
import 'package:booknest/utility/section/best_section.dart';
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
                    final category = majorcategories[index % majorcategories.length];
                    return CategoryCard(
                      title: category['title']!,
                      image: category['image']!,
                      onTap: () {
                        switch (category['title']) {
                          case 'Cinematic':
                            Navigator.pushNamed(context, '/cinematic');
                            break;
                          case 'Best selling':
                            Navigator.pushNamed(context, '/bestsellers');
                            break;
                          case 'Latest Arrivals':
                            Navigator.pushNamed(context, '/newarrivals');
                            break;
                          default:
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          //adapted to anime,movies,web series section
          CinematicCarousel(),

          //                       //container for Web-Series
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(10),
          //                         child: Container(
          //                           //color: Colors.blue,
          //                           //color: Colors.redAccent,
          //                           height: 350,
          //                           child: Center(
          //                             child: Column(
          //                               children: [
          //                                 Text(
          //                                   'Web-Series',
          //                                   style: TextStyle(
          //                                     color:
          //                                         Theme.of(
          //                                           context,
          //                                         ).textTheme.bodyLarge?.color,
          //                                     fontSize: 20,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                 ),
          //                                 Row(
          //                                   children: [
          //                                     ClipRRect(
          //                                       borderRadius: BorderRadius.circular(10),
          //                                       child: Image.asset(
          //                                         "assets/images/got.jpg",
          //                                         width: 200,
          //                                         height: 300,
          //                                         fit: BoxFit.contain,
          //                                       ),
          //                                     ),
          //                                   ],
          //                                 ),
          //                                 Flexible(
          //                                   child: Text(
          //                                     'Rs.200',
          //                                     style: TextStyle(
          //                                       color:
          //                                           Theme.of(
          //                                             context,
          //                                           ).textTheme.bodyLarge?.color,
          //                                       fontSize: 18,
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          // */
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
            //color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bestselling Authors',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
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
                        onTap: () {},
                        name: 'Buddhisagar',
                        imagePath: 'assets/authors/buddhisagar.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Fyodor Dostoyevsky',
                        imagePath: 'assets/authors/fyodor.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Robert Greene',
                        imagePath: 'assets/authors/greene.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Sage Veda Vyasa',
                        imagePath: 'assets/authors/sage.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'A.C. Bhaktivedanta..',
                        imagePath: 'assets/authors/acb.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Colleen Hoover',
                        imagePath: 'assets/authors/colleen.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Morgan Housel',
                        imagePath: 'assets/authors/morgan.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
                        name: 'Haruki Murakami',
                        imagePath: 'assets/authors/haruki.jpg',
                      ),
                      const SizedBox(width: 20),
                      AuthorsSection(
                        onTap: () {},
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
