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

          BestSection(),

          //New Ariivals Section
          NewarrivalsSection(),

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
        ],
      ),
    );
  }
}
