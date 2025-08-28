import 'package:booknest/pages/Usersettingspage.dart';
import 'package:booknest/pages/admin.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/pages/user_signup_Page.dart';
import 'package:booknest/utility/google_auth_service.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:booknest/utility/task_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final VoidCallback? onThemeChanged;
  Login({super.key, this.onThemeChanged});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signUserIn() async {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(child: CircularProgressIndicator());
    //   },
    // );
    // print("Sign in button pressed");

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(), // Added .trim() to remove whitespace
        password: passwordcontroller.text.trim(), // Added .trim() to remove whitespace
      );
      // If sign-in is successful, check authentication state and navigate to home page
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/', // Home page route
          (route) => false, // Remove all previous routes
        );
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
          title: Center(child: Text(message, style: const TextStyle(color: Colors.white))),
        );
      },
    );
  }

  void registerUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserSignupPage(onThemeChanged: widget.onThemeChanged),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Homepage(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              //maxHeight: 600,
            ), // limit width for web
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Theme.of(context).dividerColor, // Use theme color for border
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Welcome", style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordcontroller,
                    obscureText: true, // Recommended for password fields
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
                  SizedBox(height: 10),
                  TaskButtons(text: "Sign in", onPressed: signUserIn),
                  const SizedBox(height: 10),
                  const Text("Or continue with"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: IconButton(
                          onPressed: () async {
                            // final user = await GoogleAuthService.signIn();
                            // if (user != null) {
                            //   Navigator.pushNamedAndRemoveUntil(
                            //     context,
                            //     '/',
                            //     (route) => false,
                            //   );
                            //   //setState(() {}); // Refresh or navigate if needed
                            // }
                            const String adminUid = "5o3m7cmRXcbw9FRxYGgWRPJy4Be2";

                            final user = await GoogleAuthService.signIn();
                            if (user != null) {
                              if (user.uid == adminUid) {
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
                            } else {
                              // Handle sign-in failure
                            }
                          },
                          icon: Image.asset(
                            'assets/images/google.png',
                            height: 35,
                            //width: 35,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/apple.png', height: 35, width: 35),
                        ),
                      ),
                    ],
                  ),
                  Text("Not a member?"),
                  TextButton(onPressed: registerUser, child: Text("Register now")),
                ],
              ),
            ),
          ),
        ),
      ),
      footer: FooterSection(),
    );
  }
}
