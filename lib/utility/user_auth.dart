import 'package:booknest/pages/Usersettingspage.dart';
import 'package:booknest/utility/login.dart'; // <- assuming you want to navigate to Login if not logged in
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuth extends StatelessWidget {
  final VoidCallback onThemeChanged;
  const UserAuth({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            // ✅ User is logged in, show user settings
            return Usersettingspage();
          } else {
            // ❌ User is not logged in, navigate to Login page
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(onThemeChanged: onThemeChanged),
                ),
              );
            });
            return Container(); // Dummy container during redirect
          }
        },
      ),
    );
  }
}
