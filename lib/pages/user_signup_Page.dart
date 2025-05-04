import 'package:booknest/utility/google_auth_service.dart'
    show GoogleAuthService, signinWithGoogle;
import 'package:booknest/utility/login.dart';
import 'package:booknest/utility/task_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSignupPage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  UserSignupPage({super.key, required this.onThemeChanged});

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
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    print("Sign up button pressed");
    try {
      if (passwordcontroller.text.trim() ==
          confirmPasswordController.text.trim()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email:
              emailcontroller.text.trim(), // Added .trim() to remove whitespace
          password:
              passwordcontroller.text
                  .trim(), // Added .trim() to remove whitespace
        );
        Navigator.of(context).pop();
      } else {
        showErrorMessage("Password donot match");
        Navigator.of(context).pop();
      }
      // Pop the loading dialog only on successful login (though you might navigate away instead)
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
          title: Center(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ), // limit width for web
            child: Container(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 30),
                  ),
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
                          icon: Image.asset(
                            'assets/images/apple.png',
                            height: 35,
                            width: 35,
                          ),
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
                          builder:
                              (context) =>
                                  Login(onThemeChanged: widget.onThemeChanged),
                        ),
                      );
                    },
                    child: Text("login"),
                  ),
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
      ),
    );
  }
}
