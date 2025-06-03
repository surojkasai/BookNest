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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuth extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const UserAuth({super.key, required this.onThemeChanged});

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
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
            final user = snapshot.data!;
            // Check admin and navigate
            FirebaseFirestore.instance.collection('admins').doc(user.uid).get().then((adminDoc) {
              if (adminDoc.exists && adminDoc.data()?['isAdmin'] == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => AdminBookUploadPage()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Usersettingspage()),
                );
              }
            });

            return Center(child: CircularProgressIndicator()); // waiting to navigate
          } else {
            // User not logged in, navigate to Login
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(onThemeChanged: widget.onThemeChanged),
                ),
              );
            });
            return Container();
          }
        },
      ),
    );
  }
}
