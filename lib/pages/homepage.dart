import 'package:booknest/config.dart';
import 'package:booknest/pages/Usersettingspage.dart';
import 'package:booknest/pages/admin.dart';
import 'package:booknest/pages/login.dart';
import 'package:booknest/utility/featured/search/search_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final VoidCallback? onThemeChanged;
  final Widget body;
  final Widget footer;

  Homepage({super.key, this.onThemeChanged, required this.body, required this.footer});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = "Cinematic";

  // 🎨 Color constants
  final Color backgroundColor = const Color(0xFF0E0B16);
  final Color appBarColor = const Color(0xFF1B152A);
  final Color primaryText = const Color(0xFFEDE9FF);
  final Color secondaryText = const Color(0xFFB8B2D8);
  final Color accentPurple = const Color(0xFF7F5AF0);

  void showSearchDialog() {
    showDialog(context: context, builder: (context) => SearchDialogue());
  }

  void userState() {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(onThemeChanged: widget.onThemeChanged)),
      );
      return;
    }

    // Always go to user settings page - it will show appropriate options based on user role
    Navigator.push(context, MaterialPageRoute(builder: (context) => Usersettingspage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: appBarColor,
          elevation: 0,

          title: Row(
            children: [
              // Logo / Title
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: Text(
                  "BookNest",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: primaryText),
                ),
              ),

              const SizedBox(width: 40),

              // Category dropdown
              DropdownButton<String>(
                value: selectedCategory,
                dropdownColor: appBarColor,
                icon: Icon(Icons.arrow_drop_down, color: secondaryText),
                underline: const SizedBox(),
                style: TextStyle(fontSize: 20, color: primaryText),
                items:
                    ["Cinematic", "Best Selling", "New Arrivals"]
                        .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                        .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });

                  switch (newValue) {
                    case 'Cinematic':
                      Navigator.pushNamed(context, '/cinematic');
                      break;
                    case 'Best Selling':
                      Navigator.pushNamed(context, '/bestsellers');
                      break;
                    case 'New Arrivals':
                      Navigator.pushNamed(context, '/newarrivals');
                      break;
                  }
                },
              ),

              const SizedBox(width: 50),

              // 🔍 Glassmorphism Search Box
              Flexible(
                child: GestureDetector(
                  onTap: showSearchDialog,
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF), // glass effect
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: TextField(
                      onTap: showSearchDialog,
                      readOnly: true,
                      style: TextStyle(color: primaryText),
                      decoration: InputDecoration(
                        hintText: "What do you want to read?",
                        hintStyle: TextStyle(color: secondaryText),
                        prefixIcon: Icon(Icons.search, color: secondaryText),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Right-side icons
          actions: [
            IconButton(
              onPressed: () => widget.onThemeChanged?.call(),
              icon: Icon(Icons.brightness_6, color: primaryText),
              padding: const EdgeInsets.symmetric(horizontal: 32),
            ),
            IconButton(
              onPressed: userState,
              icon: Icon(Icons.person, color: primaryText),
              padding: const EdgeInsets.symmetric(horizontal: 32),
            ),
            // Conditional cart/admin icon based on user role
            Builder(
              builder: (context) {
                final User? currentUser = FirebaseAuth.instance.currentUser;
                final bool isAdmin = currentUser?.uid == Config.adminUID;

                return IconButton(
                  onPressed: () {
                    if (isAdmin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminBookUploadPage()),
                      );
                    } else {
                      Navigator.pushNamed(context, '/usercart');
                    }
                  },
                  icon: Icon(
                    isAdmin ? Icons.admin_panel_settings : Icons.shopping_cart,
                    color: primaryText,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(child: Column(children: [widget.body, widget.footer])),
    );
  }
}
