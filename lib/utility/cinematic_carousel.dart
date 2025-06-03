import 'package:booknest/pages/book_details.dart';
import 'package:flutter/material.dart';

class CinematicCarousel extends StatelessWidget {
  const CinematicCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final cinematiclist = [];
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 355,
          color: Colors.blue,
          child: Row(children: [_buildTextSection(), const Spacer(), _buildMediaItems(context)]),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Container(
      width: 400,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              const Text('Cinematic', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Text(
                  'Adaptation',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 60.0),
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
                    Text('with ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _buildMediaItems(BuildContext context) {
    return Row(
      children: [
        _buildMediaItem(context, 'Anime', 'assets/bookImages/Demon_Slayer.jpg', 500, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookDetailsPage(
                    titleText: "Cinematic Adaptation\n",
                    capText: 'Start with Originals',
                    title: 'Demon-Slayer',
                    imagePath: 'assets/bookImages/Demon_Slayer.jpg',
                    price: 500,
                    author: 'by Koyoharu Gotouge',
                    description:
                        'Tanjiro sets out on the path of the Demon Slayer to save his sister and avenge his family! In Taisho-era Japan, Tanjiro Kamado is a kindhearted boy who makes a living selling charcoal. But his peaceful life is shattered when a demon slaughters his entire family. His little sister Nezuko is the only survivor, but she has been transformed into a demon herself! Tanjiro sets out on a dangerous journey to find a way to return his sister to normal and destroy the demon who ruined his life. Learning to destroy demons won’t be easy, and Tanjiro barely knows where to start. The surprise appearance of another boy named Giyu, who seems to know what’s going on, might provide some answers—but only if Tanjiro can stop Giyu from killing his sister first!',
                  ),
            ),
          );
        }),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Movie', 'assets/bookImages/harrypotter.jpg', 600, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookDetailsPage(
                    titleText: "Cinematic Adaptation\n",
                    capText: 'Start with Originals',
                    title: 'Harry Potter and the Philosophers Stone',
                    imagePath: 'assets/bookImages/harrypotter.jpg',
                    price: 600,
                    author: 'by J. K. Rowling',
                    description:
                        'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harrys eleventh birthday, a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard, and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. Its time to PASS THE MAGIC ON .',
                  ),
            ),
          );
        }),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Game', 'assets/bookImages/the_witcher.jpg', 700, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookDetailsPage(
                    titleText: "Cinematic Adaptation\n",
                    capText: 'Start with Originals',
                    title: 'Game',
                    imagePath: 'assets/bookImages/the_witcher.jpg',
                    price: 700,
                    author: 'by Andrzej Sapkowski',
                    description:
                        'Meet Geralt of Rivia - the Witcher - who holds the line against the monsters plaguing humanity in the bestselling series that inspired the Witcher video games and a major Netflix show.The Witchers magic powers and lifelong training have made him a brilliant fighter and a merciless assassin.Yet he is no ordinary killer: he hunts the vile fiends that ravage the land and attack the innocent.But not everything monstrous-looking is evil; not everything fair is good . . . and in every fairy tale there is a grain of truth.Translated by Danusia Stok and David French.Andrzej Sapkowski, winner of the World Fantasy Lifetime Achievement award, started an international phenomenon with his Witcher series. This boxed set contains all eight books: THE LAST WISH, SWORD OF DESTINY, BLOOD OF ELVES, TIME OF CONTEMPT, BAPTISM OF FIRE, THE TOWER OF THE SWALLOW, THE LADY OF THE LAKE, SEASON OF STORMS.',
                  ),
            ),
          );
        }),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Web-Series', 'assets/bookImages/got.jpg', 800, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BookDetailsPage(
                    titleText: "Cinematic Adaptation\n",
                    capText: 'Start with Originals',
                    title: 'A Game of Thrones',
                    imagePath: 'assets/bookImages/got.jpg',
                    price: 800,
                    author: 'by George R. R. Martin',
                    description:
                        'Long ago, in a time forgotten, a preternatural event threw the seasons out of balance. In a land where summers can last decades and winters a lifetime, trouble is brewing. The cold is returning, and in the frozen wastes to the north of Winterfell, sinister forces are massing beyond the kingdoms protective Wall. To the south, the kings powers are failing: his most trusted advisor dead under mysterious circumstances and his enemies emerging from the shadows of the throne. At the center of the conflict lie the Starks of Winterfell, a family as harsh and unyielding as the frozen land they were born to. Now Lord Eddard Stark is reluctantly summoned to serve as the kings new Hand, an appointment that threatens to sunder not only his family but the kingdom itself. Sweeping from a harsh land of cold to a summertime kingdom of epicurean plenty, A Game of Thrones tells a tale of lords and ladies, soldiers and sorcerers, assassins and bastards who come together in a time of grim omens. Here, an enigmatic band of warriors bear swords of no human metal, a tribe of fierce wildings carry men off into madness, a cruel young dragon prince barters ... [more]his sister to win back his throne, a child is lost in the twilight between life and death, and a determined woman undertakes a treacherous journey to protect all she holds dear. Amid plots and counterplots, tragedy and betrayal, victory and terror, allies and enemies, the fate of the Starks hangs perilously in the balance, as each side endeavors to win that deadliest of conflicts: the game of thrones.',
                  ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMediaItem(
    BuildContext context,
    String title,
    String imagePath,
    double price,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(imagePath, width: 200, height: 300, fit: BoxFit.contain),
          ),
          Text(
            'Rs.${price.toString()}',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// //new
// import 'package:booknest/db/book.dart'; // Import your Book model
// import 'package:booknest/pages/book_details.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import for ValueListenableBuilder
// import 'dart:typed_data'; // For Uint8List

// class CinematicCarousel extends StatelessWidget {
//   const CinematicCarousel({super.key});

//   // Updated _pushBookDetails to accept a Book object
//   void _pushBookDetails(
//     BuildContext context,
//     Book book, // Pass the entire Book object
//   ) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder:
//             (context) => BookDetailsPage(
//               titleText: "Cinematic Adaptation\n",
//               capText: 'Start with Originals',
//               title: book.title,
//               // imagePath is no longer directly used, imageBytes is
//               //imagePath: '', // Will be handled by imageBytes in BookDetailsPage
//               imageBytes: book.imageBytes, // Pass the imageBytes
//               price: book.price,
//               author: book.author,
//               description: book.description,
//             ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 40, left: 40),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           height: 355,
//           color: Colors.blue, // Consider using Theme.of(context).primaryColor or a custom color
//           child: Row(
//             children: [
//               _buildTextSection(context), // Pass context to access theme
//               const Spacer(),
//               // Use ValueListenableBuilder here to get cinematic books
//               _buildMediaItems(context), // This will contain the ValueListenableBuilder
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextSection(BuildContext context) {
//     // Accept context
//     return Container(
//       width: 400,
//       alignment: Alignment.centerLeft,
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40.0),
//           child: Column(
//             children: [
//               Text(
//                 'Cinematic',
//                 style: TextStyle(
//                   fontSize: 60,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).textTheme.titleLarge?.color, // Use theme colors
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 0.0),
//                 child: Text(
//                   'Adaptation',
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.amber, // Still amber as per original
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 60.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Start ',
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.amber, // Still amber
//                       ),
//                     ),
//                     Text(
//                       'with ',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).textTheme.titleLarge?.color, // Use theme colors
//                       ),
//                     ),
//                     Text(
//                       'originals',
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.amber, // Still amber
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMediaItems(BuildContext context) {
//     return ValueListenableBuilder<Box<Book>>(
//       valueListenable: Hive.box<Book>('books').listenable(),
//       builder: (context, box, _) {
//         // Filter books for the 'Cinematic' category
//         final List<Book> cinematicBooks =
//             box.values.where((book) => book.category == 'Cinematic').toList();

//         // Optional: Limit the number of books displayed in the carousel
//         // For example, show only the first 4 cinematic books
//         final List<Book> displayBooks = cinematicBooks.take(4).toList(); // Show top 4

//         if (displayBooks.isEmpty) {
//           return const Expanded(
//             child: Center(
//               child: Text(
//                 'No cinematic books found.',
//                 style: TextStyle(color: Colors.white), // Adjust color for blue background
//               ),
//             ),
//           );
//         }

//         return Flexible(
//           // Make this part flexible to take available space
//           child: Row(
//             children:
//                 displayBooks.map((book) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 20.0), // Spacing between items
//                     child: _buildMediaItem(
//                       context,
//                       book.title,
//                       book.imageBytes, // Pass imageBytes directly
//                       book.price,
//                       () => _pushBookDetails(context, book), // Pass the whole book object
//                     ),
//                   );
//                 }).toList(),
//           ),
//         );
//       },
//     );
//   }

//   // Updated _buildMediaItem to accept Uint8List? for image
//   Widget _buildMediaItem(
//     BuildContext context,
//     String title,
//     Uint8List? imageBytes, // Changed from String imagePath
//     double price,
//     VoidCallback onTap,
//   ) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0), // Space below title
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               maxLines: 2, // Limit title to 2 lines
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: Theme.of(context).textTheme.titleLarge?.color, // Use theme colors
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: SizedBox(
//               // Give fixed size to the image container
//               width: 150, // Smaller width for carousel items
//               height: 220, // Corresponding height
//               child:
//                   imageBytes != null && imageBytes!.isNotEmpty
//                       ? Image.memory(imageBytes!, fit: BoxFit.contain) // Display image from bytes
//                       : Container(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         child: Icon(
//                           Icons.book,
//                           size: 60,
//                           color: Theme.of(context).colorScheme.onSecondary,
//                         ),
//                       ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0), // Space above price
//             child: Text(
//               'Rs.${price.toStringAsFixed(2)}', // Format price
//               style: TextStyle(
//                 color: Theme.of(context).textTheme.titleLarge?.color, // Use theme colors
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
