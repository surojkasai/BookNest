import 'package:booknest/utility/section/footer_column.dart';
import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top part with links
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Links
              FooterColumn(
                title: 'QUICK LINKS',
                items: [
                  MapEntry('Best Sellers', () {
                    Navigator.pushNamed(context, '/bestsellers');
                  }),
                  MapEntry('New Arrivals', () {
                    Navigator.pushNamed(context, '/newarrivals');
                  }),
                ],
              ),
              SizedBox(width: 50),
              // About
              FooterColumn(
                title: 'ABOUT',
                items: [
                  MapEntry('About Us', () {
                    Navigator.pushNamed(context, '/aboutus');
                  }),
                  MapEntry('Contact', () {
                    Navigator.pushNamed(context, '/aboutus');
                  }),
                ],
              ),
              SizedBox(width: 50),
              // Genres
              // FooterColumn(
              //   title: 'GENRES',
              //   items: [
              //     'Fiction',
              //     'Self Help',
              //     'Business',
              //     'Children',
              //     'Nepali',
              //   ],
              // ),
              SizedBox(width: 50),
              // Others
              // FooterColumn(
              //   title: 'OTHERS',
              //   items: ['Cafe', "FAQ's", 'Shipping Rates'],
              // ),
              // Spacer(),
              // Promo box
              // Container(
              //   width: 300,
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[900],
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       RichText(
              //         text: TextSpan(
              //           style: TextStyle(color: Colors.white, fontSize: 16),
              //           children: [
              //             TextSpan(text: 'Signup and '),
              //             TextSpan(
              //               text: 'Unlock 10% OFF',
              //               style: TextStyle(color: Colors.redAccent),
              //             ),
              //             TextSpan(text: '\nOn your first purchase!'),
              //           ],
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         'Opt in to our newsletter on BooksMandala for exclusive deals, updates, and more!',
              //         style: TextStyle(color: Colors.grey[400], fontSize: 12),
              //       ),
              //       SizedBox(height: 15),
              //       Row(
              //         children: [
              //           Container(
              //             color: Colors.amber[100],
              //             padding: const EdgeInsets.symmetric(
              //               vertical: 6,
              //               horizontal: 10,
              //             ),
              //             child: Text(
              //               'CODE',
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //           SizedBox(width: 10),
              //           ElevatedButton(onPressed: () {}, child: Text("SIGNUP")),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 40),
          Divider(color: Colors.grey),
          SizedBox(height: 10),

          // Bottom copyright
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 BookNest     •     Terms Of Use     •     Privacy Policy',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {
                      // Add your Facebook link or action here
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {
                      // Add your Instagram or camera-related action
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.discord),
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {
                      // Add your Discord link or action
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
