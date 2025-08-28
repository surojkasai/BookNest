// book_details_page.dart
import 'dart:typed_data';

import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

int deliveryCharge = 0;

class BookDetailsPage extends StatelessWidget {
  final VoidCallback? onThemeChanged;
  // final Widget footer;
  final String title;
  //final String imagePath;
  final Uint8List? imageBytes;
  final double price;
  final String titleText;
  final String capText;
  final String author;
  final String description;
  //final String category;

  const BookDetailsPage({
    super.key,
    required this.title,
    //required this.imagePath,
    this.imageBytes,
    required this.price,
    required this.capText,
    required this.titleText,
    required this.author,
    required this.description,
    this.onThemeChanged,
    //required this.category,
    // required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 40.0, left: 40),
          child: Column(
            children: [
              // Title and subtitle
              Container(
                height: 100,
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, decoration: TextDecoration.none),
                    children: <TextSpan>[
                      TextSpan(
                        text: titleText,
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: capText,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Book content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Image
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        //Image.asset(imagePath, height: 400),
                        imageBytes != null && imageBytes!.isNotEmpty
                            ? Image.memory(
                              width: 220, // Consistent width for each card
                              height: 350,
                              imageBytes!,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                                ); // Fallback for image loading error
                              },
                            )
                            : const Center(
                              child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                            ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: Theme.of(context).textTheme.headlineMedium),
                              Text(
                                author,
                                style: TextStyle(
                                  color: Colors.purple, // change this to your desired color
                                  fontSize: 16, // optional
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                description,
                                style: Theme.of(context).textTheme.bodyLarge,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Right: Details and Add to Cart
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        //color: Colors.grey.shade200,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Subtotal:', style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Text('Rs.$price', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Delivery:', style: TextStyle(fontSize: 16)),
                              Spacer(),
                              Text('$deliveryCharge', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(thickness: 1),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),

                              Text(
                                'Rs.${price + deliveryCharge}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Provider.of<CartProvider>(context, listen: false).addItem(
                                      title,
                                      author, // or pass author as parameter
                                      price,
                                      //imagePath,
                                      imageBytes,
                                    );
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(const SnackBar(content: Text("Added to cart")));
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/usercart');
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "View Cart",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ),
                              ],
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
      footer: FooterSection(),
    );
  }
}
