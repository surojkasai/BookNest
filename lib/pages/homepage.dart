import 'package:booknest/pages/Usersettingspage.dart';
import 'package:booknest/pages/login.dart';
import 'package:booknest/utility/featured/search/search_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount;

class Homepage extends StatefulWidget {
  final VoidCallback? onThemeChanged;

  final Widget body;
  final Widget footer;

  Homepage({
    super.key,
    this.onThemeChanged,
    required this.body,
    required this.footer,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final _textEditingController = TextEditingController();

  String selectedCategory = "Cinematic";
  String? selectedGenre;

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SearchDialogue();
      },
    );
  }

  void searchItems() {}

  //this was causing error because i was calling a scaffold inside the dailogbox which is not possible
  // void userState() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return UserAuth();
  //     },
  //   );
  // }

  // void userState() async {
  //   User? firebaseUser =
  //       FirebaseAuth.instance.currentUser; // Check if the user is logged in

  //   // Check if the user is logged in with Google
  //   GoogleSignIn googleSignIn = GoogleSignIn();
  //   GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   if (firebaseUser != null || googleUser != null) {
  //     // If user is logged in, show user settings page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Usersettingspage(), // User Settings page
  //       ),
  //     );
  //   } else {
  //     // If user is not logged in, navigate to the login page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Login(onThemeChanged: widget.onThemeChanged),
  //       ),
  //     );
  //   }
  // }

  void userState() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    //user is logged in
    if (firebaseUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(onThemeChanged: widget.onThemeChanged),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Usersettingspage(), // User Settings page
        ),
      );
    }
  }

  void userCart() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          //backgroundColor: Colors.amber,
          title: Row(
            children: [
              //SizedBox(width: 80),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                child: Text(
                  "Book-Nest",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 40)),
              

              // DropdownButton<String>(
              //   value: selectedGenre,
              //   hint: Text("Genre"),
              //   icon: Icon(Icons.arrow_drop_down),
              //   focusColor: Colors.transparent,
              //   //hides the iconr
              //   //icon: SizedBox(),
              //   underline: SizedBox(),
              //   //focusColor: Colors.transparent,
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Theme.of(context).textTheme.bodyLarge?.color,
              //   ),
              //   items:
              //       [
              //         "Genre",
              //         "Manga",
              //         "Manhwa",
              //         "Manhua",
              //         "Fiction and Literature",
              //         "Foreign Languages",
              //         "History, Biography",
              //         "Kids and Teens",
              //         "Learning and Reference",
              //         "Lifestyle and Wellness",
              //         "Miscellaneous",
              //         "Nature ",
              //       ].map((String category) {
              //         return DropdownMenuItem<String>(
              //           value: category == "Genre" ? null : category,
              //           child: Text(category),
              //         );
              //       }).toList(),

              //   onChanged: (newValue) {
              //     setState(() {
              //       selectedGenre = newValue!;
              //     });
              //   },
              // ),

              // DropdownButton<String>(
              //   value: selectedCategory,
              //   icon: Icon(Icons.arrow_drop_down),
              //   underline: SizedBox(),
              //   focusColor: Colors.transparent,
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Theme.of(context).textTheme.bodyLarge?.color,
              //   ),
              //   items:
              //       ["Cinematic", "Best Selling", "New Arrivals"].map((
              //         String category,
              //       ) {
              //         return DropdownMenuItem<String>(
              //           value: category,
              //           child: Text(category),
              //         );
              //       }).toList(),
              //   onChanged: (newValue) {
              //     setState(() {
              //       selectedCategory = newValue!;
              //     });
              //   },
              // ),
              // SizedBox(width: 50),
              DropdownButton<String>(
                value: selectedCategory,
                icon: Icon(Icons.arrow_drop_down),
                underline: SizedBox(),
                focusColor: Colors.transparent,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                items:
                    ["Cinematic", "Best Selling", "New Arrivals"].map((
                      String category,
                    ) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });

                  switch (newValue) {
                    // case 'Home':
                    //   //Navigator.pushNamed(context, '/');
                    //   break;
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
              SizedBox(width: 50),

              Flexible(
                child: GestureDetector(
                  onTap: showSearchDialog,
                  child: Center(
                    child: Container(
                      width: double.infinity, // Adjust width for search field
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        onTap: showSearchDialog,
                        decoration: InputDecoration(
                          hintText: "What do you want to read?",
                          //hintStyle: TextStyle(color: Colors.white54),
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          //fillColor: Colors.grey[900],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //for theme
          actions: [
            IconButton(
              onPressed: () => widget.onThemeChanged?.call(),
              icon: Icon(Icons.brightness_6),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ), // Adds horizontal padding
            ),

            //for user login
            IconButton(
              onPressed: userState,
              icon: Icon(Icons.person),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ), // Adds horizontal padding
            ),

            //for cart
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/usercart');
              },
              icon: Icon(Icons.shopping_cart),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ), // Adds horizontal padding
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.body,
            widget.footer, // 👈 this will always appear at the bottom
          ],
        ),
      ),
    );
  }
}
