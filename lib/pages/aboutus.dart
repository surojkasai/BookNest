import 'package:flutter/material.dart';

class AboutAndContactPage extends StatelessWidget {
  const AboutAndContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About & Contact'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ABOUT US SECTION
            const Text(
              'About Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to BookNest — your one-stop destination for discovering and purchasing your favorite books. '
              'Our mission is to inspire reading by offering a wide variety of books including best sellers, academic resources, and hidden gems. '
              'We aim to create a smooth, reliable, and user-friendly shopping experience for all book lovers.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // CONTACT SECTION
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Have questions or feedback? We’d love to hear from you!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'support@booknest.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 10),
                Text('+977-9876543210', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '123 Book Street, Kathmandu, Nepal',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
