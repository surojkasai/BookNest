import 'package:booknest/main.dart';
import 'package:booknest/utility/task_buttons.dart';
import 'package:flutter/material.dart';

class SearchDialogue extends StatelessWidget {
  VoidCallback search;
  SearchDialogue({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      content: Container(
        height: 500,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(
                //color: Theme.of(context).textTheme.bodyLarge?.color,
                //color: Colors.black,
              ),
              decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [TaskButtons(text: "Search", onPressed: search)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
