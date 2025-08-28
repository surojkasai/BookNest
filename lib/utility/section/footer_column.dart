import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FooterColumn extends StatelessWidget {
  final String title;
  //final List<String> items;
  final List<MapEntry<String, VoidCallback>> items;
  const FooterColumn({super.key, required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),

        // ...items.map(
        //   (item) => Padding(
        //     padding: const EdgeInsets.only(bottom: 8),
        //     child: GestureDetector(
        //       onTap: () {
        //         // Add navigation or action logic here
        //       },
        //       child: Text(
        //         item,
        //         style: TextStyle(color: Colors.grey[400], fontSize: 14),
        //       ),
        //     ),
        //   ),
        // ),
        ...items.map(
          (item) => TextButton(
            onPressed: item.value,
            child: Text(
              item.key,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
