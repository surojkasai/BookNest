// import 'package:booknest/pages/Usersettingspage.dart';
// import 'package:booknest/pages/login.dart'; // <- assuming you want to navigate to Login if not logged in
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class UserAuth extends StatelessWidget {
//   final VoidCallback onThemeChanged;
//   const UserAuth({super.key, required this.onThemeChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasData) {
//             // ✅ User is logged in, show user settings
//             return Usersettingspage();
//           } else {
//             // ❌ User is not logged in, navigate to Login page
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => Login(onThemeChanged: onThemeChanged)),
//               );
//             });
//             return Container(); // Dummy container during redirect
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:booknest/pages/Usersettingspage.dart';
import 'package:booknest/pages/admin.dart';
import 'package:booknest/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuth extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const UserAuth({super.key, required this.onThemeChanged});

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  bool? isAdmin;
  static const String adminUID =
      '5o3m7cmRXcbw9FRxYGgWRPJy4Be2'; // ← 🔁 Replace with your actual UID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Auth"),
        actions: [
          if (isAdmin != null)
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, isAdmin! ? '/admin' : '/', (_) => false);
              },
              child: Text(isAdmin! ? "Admin" : "Home", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (user == null) {
            // Not logged in
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Login(onThemeChanged: widget.onThemeChanged)),
              );
            });
            return SizedBox();
          }

          // Logged in, check admin role if not already determined
          if (isAdmin == null) {
            _checkUserRole(user.uid);
            return Center(child: CircularProgressIndicator());
          }

          // Show the appropriate page
          return isAdmin! ? AdminBookUploadPage() : Usersettingspage();
        },
      ),
    );
  }

  Future<void> _checkUserRole(String uid) async {
    setState(() {
      isAdmin = uid == adminUID;
    });
  }
}
