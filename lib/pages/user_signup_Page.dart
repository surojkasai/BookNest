import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/google_auth_service.dart' show GoogleAuthService, signinWithGoogle;
import 'package:booknest/pages/login.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:booknest/utility/task_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSignupPage extends StatefulWidget {
  final VoidCallback? onThemeChanged;
  UserSignupPage({super.key, this.onThemeChanged});

  @override
  State<UserSignupPage> createState() => _UserSignupPage();
}

class _UserSignupPage extends State<UserSignupPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      if (passwordcontroller.text.trim() != confirmPasswordController.text.trim()) {
        Navigator.pop(context);
        showErrorMessage("Passwords do not match");
        return;
      }

      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      // Send verification email
      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Navigator.pop(context); // Close the loading dialog

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Verify Your Email"),
                content: const Text(
                  "A verification email has been sent. Please check your inbox before logging in.",
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
                ],
              ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.message ?? "An error occurred.");
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

  @override
  Widget build(BuildContext context) {
    return Homepage(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // limit width for web
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
                  const Text("Create an Account", style: TextStyle(fontSize: 30)),
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
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true, // Recommended for password fields
                    decoration: const InputDecoration(
                      hintText: "confirm  password",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 10),
                  TaskButtons(text: "Sign up", onPressed: signUserUp),
                  const SizedBox(height: 10),
                  const Text("Or continue with"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: IconButton(
                          onPressed: () async {
                            final user = await GoogleAuthService.signIn();
                            if (user != null) {
                              print("Signed in: ${user.displayName}");
                              Navigator.pushReplacementNamed(context, '/');
                              setState(() {});
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
                  Text("Already a member?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(onThemeChanged: widget.onThemeChanged),
                        ),
                      );
                    },
                    child: Text("login"),
                  ),
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
