import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/db/book.dart';
import 'package:booknest/pages/aboutus.dart';
import 'package:booknest/pages/cinematic.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/pages/best_sellers_page.dart'; // import your new page
import 'package:booknest/pages/mainbody.dart';
import 'package:booknest/pages/new_arrivals_page.dart';
import 'package:booknest/pages/user_cart.dart';
import 'package:booknest/paymentmethod/esewa_state.dart';
import 'package:booknest/provider/cart_provider.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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

  //initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  final bookBox = await Hive.openBox<Book>('books');

  //hive seeding logic //seeding means a way to access the static data by making it dynamic

  // if (bookBox.isEmpty) {
  //   print('Hive box is empty. Seeding initial data...');
  //   final initialBooks = await getInitialBooks();
  //   await bookBox.addAll(initialBooks); // Add all books at once
  //   print('Initial data seeded successfully.');
  // } else {
  //   print('Hive box already contains data. Skipping seeding.');
  // }

  runApp(
    KhaltiScope(
      publicKey: 'a212c030ff134d488c83449a7d427ac2', // Khalti public key
      navigatorKey: navigatorKey,
      builder: (context, navigatorKey) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
          child: MyApp(),
        );
      },
    ),
  );
  ;
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
        '/cinematic':
            (context) => cinematicpage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/bestsellers':
            (context) => bestSellersPage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/newarrivals':
            (context) => NewArrivalsPage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/usercart':
            (context) => ShoppingCartPage(
              //onThemeChanged: toggleTheme,
              //footer: FooterSection(),
            ),
        '/aboutus': (context) => AboutAndContactPage(),
        '/payment-success': (context) => PaymentSuccessPage(),
        '/payment-failure': (context) => PaymentFailurePage(),
        //'/user-settings': (context) => Usersettingspage(),
        //'/login': (context) => Login(onThemeChanged: toggleTheme),

        // Add more routes here if needed
      },
    );
  }
}
