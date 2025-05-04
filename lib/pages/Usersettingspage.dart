import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Usersettingspage extends StatefulWidget {
  Usersettingspage({super.key});

  @override
  State<Usersettingspage> createState() => _UsersettingspageState();
}

class _UsersettingspageState extends State<Usersettingspage> {
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context); // ✅ Correct usage with context
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Flexible(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color:
                    Theme.of(
                      context,
                    ).dividerColor, // Use theme color for border
                width: 2.0,
              ),
            ),
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "Welcome ${user?.email ?? "User"}",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                IconButton(
                  onPressed: () => signUserOut(context),
                  icon: Icon(Icons.logout),
                  tooltip: "Sign Out",
                ),
                TextButton(onPressed: () {}, child: Text("Forgot Password?")),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  child: Text("Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
