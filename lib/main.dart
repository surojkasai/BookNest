import 'package:booknest/pages/homepage.dart';
import 'package:booknest/pages/best_sellers_page.dart'; // import your new page
import 'package:booknest/pages/mainbody.dart';
import 'package:booknest/pages/new_arrivals_page.dart';
import 'package:booknest/pages/user_cart.dart';
import 'package:booknest/provider/cart_provider.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
    options: FirebaseOptions(
      apiKey: "AIzaSyC1BbSCCPZ3m8FQMzS6WXmVJV8CDfVfRIg",
      appId: "1:917866687436:web:9df0f5579d9a0b7cb40b69",
      messagingSenderId: "917866687436",
      projectId: "booknest-54526",
    ),
  );
  runApp(
    KhaltiScope(
      publicKey:
          'test_public_key_dc74c7f2383341e78c1fbd8e2a4a3f2d', // Khalti public key
      builder: (context, navigatorKey) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
          child: MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;
  Future getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Signed in as: ${user.email}');
    }
    setState(() {});
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),

      // ✅ Replace `home:` with `initialRoute:` and define routes
      initialRoute: '/',
      routes: {
        '/':
            (context) => Homepage(
              onThemeChanged: toggleTheme,
              body: Mainbody(),
              footer: FooterSection(),
              //footer: FooterSection(),
            ),
        '/bestsellers':
            (context) => bestSellersPage(
              onThemeChanged: toggleTheme,
              footer: FooterSection(),
            ),
        '/newarrivals':
            (context) => NewArrivalsPage(
              onThemeChanged: toggleTheme,
              footer: FooterSection(),
            ),
        '/usercart':
            (context) => ShoppingCartPage(
              //onThemeChanged: toggleTheme,
              //footer: FooterSection(),
            ),
        //'/user-settings': (context) => Usersettingspage(),
        //'/login': (context) => Login(onThemeChanged: toggleTheme),

        // Add more routes here if needed
      },
    );
  }
}
