import 'package:booknest/utility/featured/body_carousel.dart';
import 'package:booknest/utility/task_buttons.dart';
import 'package:flutter/material.dart';
import 'package:booknest/main.dart';

final List<Map<String, String>> majorcategories = [
  {"title": "Manga", "image": "assets/images/manga.jpg"},
  {"title": "Children Books", "image": "assets/images/children.jpg"},
  {"title": "Used Books", "image": "assets/images/used.jpg"},
  {"title": "Tarot", "image": "assets/images/tarrot.jpg"},
  {"title": "Tarot", "image": "assets/images/latest.jpg"},
];

final List<Map<String, String>> bestSellercategories = [
  {"title": "Manga", "image": "assets/images/manga.jpg"},
  {"title": "Children Books", "image": "assets/images/children.jpg"},
  {"title": "Used Books", "image": "assets/images/used.jpg"},
  {"title": "Tarot", "image": "assets/images/tarrot.jpg"},
];

class LoopingCategoryList extends StatefulWidget {
  @override
  _LoopingCategoryListState createState() => _LoopingCategoryListState();
}

class _LoopingCategoryListState extends State<LoopingCategoryList> {
  final ScrollController _controller = ScrollController();
  final int _repeatFactor = 1000;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start at a middle index to allow both forward and backward scrolling
      final middle = (majorcategories.length * _repeatFactor) ~/ 2;
      _controller.jumpTo(middle * 200); // Adjust item width accordingly
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      interactive: true,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = majorcategories[index % majorcategories.length];
          return CategoryCard(
            title: category['title']!,
            image: category['image']!,
          );
        },
        itemCount: majorcategories.length * _repeatFactor,
      ),
    );
  }
}
