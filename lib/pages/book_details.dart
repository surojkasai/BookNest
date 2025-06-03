// book_details_page.dart
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
  final String imagePath;
  final double price;
  final String titleText;
  final String capText;
  final String author;
  final String description;

  const BookDetailsPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.capText,
    required this.titleText,
    required this.author,
    required this.description,
    this.onThemeChanged,
    // required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Homepage(
      onThemeChanged: onThemeChanged,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                        Image.asset(imagePath, height: 400),
                        const SizedBox(width: 10),
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
                                overflow: TextOverflow.visible,
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
                                      imagePath,
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

//new

// // book_details_page.dart
// import 'package:booknest/pages/homepage.dart';
// import 'package:booknest/utility/section/footer_section.dart';
// import 'package:flutter/material.dart';
// //import 'package:provider/provider';
// import 'package:provider/provider.dart';
// import '../provider/cart_provider.dart';
// import 'dart:typed_data'; // Import for Uint8List

// int deliveryCharge =
//     0; // This seems to be a global or top-level variable. Consider making it part of a stateful widget or a provider if it needs to change.

// class BookDetailsPage extends StatelessWidget {
//   final VoidCallback? onThemeChanged;
//   final String title;
//   // Change imagePath to imageBytes (and make it nullable)
//   final Uint8List? imageBytes; // Changed from String imagePath
//   final double price;
//   final String titleText;
//   final String capText;
//   final String author;
//   final String description;

//   const BookDetailsPage({
//     super.key,
//     required this.title,
//     this.imageBytes, // Changed from required this.imagePath
//     required this.price,
//     required this.capText,
//     required this.titleText,
//     required this.author,
//     required this.description,
//     this.onThemeChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Homepage(
//       onThemeChanged: onThemeChanged,
//       footer: FooterSection(), // Footer was commented out, added it back
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               // Title and subtitle
//               Container(
//                 height: 100,
//                 alignment: Alignment.centerLeft,
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(color: Colors.black, decoration: TextDecoration.none),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: titleText,
//                         style: TextStyle(
//                           fontSize: 28,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: capText,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Book content
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Left: Image
//                   Expanded(
//                     flex: 2,
//                     child: Row(
//                       // Using a Row here makes sense for aligning image and text
//                       crossAxisAlignment: CrossAxisAlignment.start, // Align to top
//                       children: [
//                         // Image display using Image.memory
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10), // Added borderRadius for image
//                           child: SizedBox(
//                             // Use SizedBox to control image dimensions
//                             width: 300, // Example width
//                             height: 400, // Example height
//                             child:
//                                 imageBytes != null && imageBytes!.isNotEmpty
//                                     ? Image.memory(imageBytes!, fit: BoxFit.cover)
//                                     : Container(
//                                       // Placeholder if imageBytes are null or empty
//                                       color: Theme.of(context).secondaryHeaderColor,
//                                       child: Icon(
//                                         Icons.book,
//                                         size: 150,
//                                         color: Theme.of(context).colorScheme.onSecondary,
//                                       ),
//                                     ),
//                           ),
//                         ),
//                         const SizedBox(width: 20), // Increased space for better separation

//                         Expanded(
//                           // Let the text column take remaining space
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 title,
//                                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                                   fontWeight: FontWeight.bold, // Ensure title is bold
//                                 ),
//                               ),
//                               Text(
//                                 author,
//                                 style: TextStyle(
//                                   color:
//                                       Colors.deepPurple, // Or Theme.of(context).colorScheme.primary
//                                   fontSize: 18, // Slightly larger font for author
//                                   fontStyle: FontStyle.italic, // Italicize author for distinction
//                                 ),
//                               ),
//                               const SizedBox(height: 16), // Increased spacing
//                               Text(
//                                 description,
//                                 style: Theme.of(context).textTheme.bodyLarge,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 textAlign: TextAlign.justify,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 40), // Increased space between left and right sections
//                   // Right: Details and Add to Cart
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(20), // Increased padding
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor, // Use card color from theme
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           // Added a subtle shadow
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildPriceRow(context, 'Subtotal:', price),
//                           SizedBox(height: 12),
//                           _buildPriceRow(
//                             context,
//                             'Delivery:',
//                             deliveryCharge.toDouble(),
//                           ), // Ensure deliveryCharge is double
//                           SizedBox(height: 20),
//                           Divider(
//                             thickness: 1.5,
//                             color: Theme.of(context).dividerColor,
//                           ), // Thicker divider
//                           SizedBox(height: 12),
//                           _buildPriceRow(context, 'Total:', price + deliveryCharge, isTotal: true),
//                           SizedBox(height: 24), // Spacing before buttons
//                           _buildActionButton(context, "Add to Cart", () {
//                             Provider.of<CartProvider>(context, listen: false).addItem(
//                               title,
//                               author,
//                               price,
//                               imageBytes, // Pass imageBytes to cart provider
//                             );
//                             ScaffoldMessenger.of(
//                               context,
//                             ).showSnackBar(const SnackBar(content: Text("Added to cart")));
//                           }),
//                           SizedBox(height: 12), // Spacing between buttons
//                           _buildActionButton(context, "View Cart", () {
//                             Navigator.pushNamed(context, '/usercart');
//                           }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build price rows
//   Widget _buildPriceRow(BuildContext context, String label, double amount, {bool isTotal = false}) {
//     return Row(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 20 : 18,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//         Spacer(),
//         Text(
//           'Rs.${amount.toStringAsFixed(2)}', // Format to 2 decimal places
//           style: TextStyle(
//             fontSize: isTotal ? 20 : 18,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: Theme.of(context).textTheme.bodyLarge?.color,
//           ),
//         ),
//       ],
//     );
//   }

//   // Helper method to build action buttons
//   Widget _buildActionButton(BuildContext context, String text, VoidCallback onPressed) {
//     return SizedBox(
//       width: double.infinity, // Make button fill width
//       child: TextButton(
//         onPressed: onPressed,
//         style: TextButton.styleFrom(
//           backgroundColor: Theme.of(context).colorScheme.primary, // Use theme's primary color
//           padding: EdgeInsets.symmetric(vertical: 16), // Larger padding
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.onPrimary, // Text color that contrasts primary
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
