// import 'package:booknest/main.dart';
// import 'package:flutter/material.dart';

// class SectionImage extends StatefulWidget {
//   final String imagePath;
//   final String titleNames;
//   const SectionImage({
//     super.key,
//     required this.imagePath,
//     required this.titleNames,
//   });

//   @override
//   State<SectionImage> createState() => _SectionImageState();
// }

// class _SectionImageState extends State<SectionImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 40, left: 60),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           height: 340,
//           color: Colors.blue,
//           child: Row(
//             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: 400,
//                 //color: Colors.red,
//                 alignment: Alignment.centerLeft,

//                 child: Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         widget.titleNames,
//                         style: TextStyle(
//                           fontSize: 60,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 0.0),
//                         child: Text(
//                           widget.titleNames,
//                           style: TextStyle(
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.amber,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 60.0),
//                         child: Row(
//                           children: [
//                             Text(
//                               widget.titleNames,
//                               style: TextStyle(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.amber,
//                               ),
//                             ),
//                             Text(
//                               widget.titleNames,
//                               style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),

//                             Text(
//                               widget.titleNames,
//                               style: TextStyle(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.amber,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //first Container for Anime
//                   Container(
//                     //padding: EdgeInsets.only(left: 90),
//                     //just for testing
//                     //color: Colors.red,
//                     // for flashy colours
//                     // decoration: BoxDecoration(
//                     //   gradient: LinearGradient(
//                     //     colors: [Colors.blue, Colors.purple, Colors.pink],
//                     //     begin: Alignment.topLeft,
//                     //     end: Alignment.bottomRight,
//                     //   ),
//                     // ),
//                     //color: Colors.redAccent,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.titleNames,
//                             style: TextStyle(
//                               color:
//                                   Theme.of(context).textTheme.bodyLarge?.color,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: Image.asset(
//                                   widget.imagePath,
//                                   width: 200,
//                                   height: 300,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(width: 40),

//                   //container for Movie
//                   Container(
//                     //just for testing
//                     //color: Colors.blue,
//                     //color: Colors.redAccent,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.titleNames,
//                             style: TextStyle(
//                               color:
//                                   Theme.of(context).textTheme.bodyLarge?.color,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.asset(
//                                   widget.imagePath,
//                                   width: 200,
//                                   height: 300,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(width: 40),

//                   //Container for Game
//                   Container(
//                     //just for testing
//                     //color: Colors.blue,
//                     //color: Colors.redAccent,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.titleNames,
//                             style: TextStyle(
//                               color:
//                                   Theme.of(context).textTheme.bodyLarge?.color,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.asset(
//                                   widget.imagePath,
//                                   width: 200,
//                                   height: 300,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(width: 40),

//                   //container for Web-Series
//                   Container(
//                     padding: EdgeInsets.only(right: 35),
//                     //just for testing
//                     //color: Colors.blue,
//                     //color: Colors.redAccent,
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.titleNames,
//                             style: TextStyle(
//                               color:
//                                   Theme.of(context).textTheme.bodyLarge?.color,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(6),
//                                 child: Image.asset(
//                                   widget.imagePath,
//                                   width: 200,
//                                   height: 300,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
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
// }
