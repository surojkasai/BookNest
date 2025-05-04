import 'package:flutter/material.dart';

class CinematicCarousel extends StatelessWidget {
  const CinematicCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 60),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 350,
          color: Colors.blue,
          child: Row(
            children: [
              _buildTextSection(),
              const Spacer(),
              _buildMediaItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Container(
      width: 400,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Column(
          children: [
            const Text(
              'Cinematic',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Text(
                'Adaptation',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
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
                  Text(
                    'with ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
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
    );
  }

  Widget _buildMediaItems(BuildContext context) {
    return Row(
      children: [
        _buildMediaItem(context, 'Anime', 'assets/images/Demon_Slayer.jpg'),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Movie', 'assets/images/harrypotter.jpg'),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Game', 'assets/images/harrypotter.jpg'),
        const SizedBox(width: 40),
        _buildMediaItem(context, 'Web-Series', 'assets/images/got.jpg'),
      ],
    );
  }

  Widget _buildMediaItem(BuildContext context, String title, String imagePath) {
    return Container(
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
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    imagePath,
                    width: 200,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Flexible(
              child: Text(
                'Rs.200',
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
    );
  }
}
