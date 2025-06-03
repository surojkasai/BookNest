import 'package:flutter/material.dart';

class BookItemCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double price;
  final VoidCallback? onTap;

  const BookItemCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    this.onTap,
  });

  //this defines  the book and its details
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 350,
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(imagePath, width: 200, height: 300, fit: BoxFit.cover),
                    ),
                  ],
                ),
                Flexible(
                  child: Text(
                    'Rs.$price',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
    );
  }
}

//new

// import 'dart:typed_data';

// import 'package:flutter/material.dart';

// class BookItemCard extends StatelessWidget {
//   final String title;
//   //final String imagePath;
//   final Uint8List? imageBytes;
//   final double price;
//   final VoidCallback? onTap;

//   const BookItemCard({
//     super.key,
//     required this.title,
//     //required this.imagePath,
//     this.imageBytes,
//     required this.price,
//     this.onTap,
//   });

//   //this defines  the book and its details
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           height: 350,
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.bodyLarge?.color,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child:
//                           //Image.asset(imagePath, width: 200, height: 300, fit: BoxFit.cover),
//                           imageBytes != null &&
//                                   imageBytes!
//                                       .isNotEmpty // Check if bytes exist and are not empty
//                               ? Image.memory(
//                                 imageBytes!,
//                                 fit: BoxFit.cover,
//                               ) // Display image from bytes
//                               : Container(
//                                 // Placeholder if no imageBytes
//                                 color:
//                                     Theme.of(context).secondaryHeaderColor, // A neutral background
//                                 child: Icon(
//                                   Icons.book,
//                                   size: 80,
//                                   color: Theme.of(context).colorScheme.onSecondary, // Icon color
//                                 ),
//                               ),
//                     ),
//                   ],
//                 ),
//                 Flexible(
//                   child: Text(
//                     'Rs.$price',
//                     style: TextStyle(
//                       color: Theme.of(context).textTheme.bodyLarge?.color,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
