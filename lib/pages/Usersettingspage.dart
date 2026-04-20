import 'package:booknest/config.dart';
import 'package:booknest/pages/admin.dart';
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
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = user?.uid == Config.adminUID;

    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? 'Admin Account' : 'Account Settings'),
        backgroundColor: const Color(0xFF1B152A),
      ),
      body: Center(
        child: Flexible(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Theme.of(context).dividerColor, width: 2.0),
            ),
            height: isAdmin ? 400 : 350, // Slightly taller for admin
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "Welcome ${user?.email ?? "User"}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                if (isAdmin) ...[
                  const Text(
                    'Administrator Access',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminBookUploadPage()),
                      );
                    },
                    icon: const Icon(Icons.admin_panel_settings),
                    label: const Text('Open Admin Panel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => signUserOut(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  child: const Text("Home"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
