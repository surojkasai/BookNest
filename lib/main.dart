import 'package:booknest/bookslistsearch/allBooks.dart';
import 'package:booknest/config.dart';
import 'package:booknest/db/book.dart';
import 'package:booknest/pages/aboutus.dart';
import 'package:booknest/pages/admin.dart' show AdminBookUploadPage;
import 'package:booknest/pages/author_books_page.dart';
import 'package:booknest/pages/cinematic.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/pages/best_sellers_page.dart';
import 'package:booknest/pages/mainbody.dart';
import 'package:booknest/pages/new_arrivals_page.dart';
import 'package:booknest/pages/admin.dart';
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
    options: FirebaseOptions(
      apiKey: Config.firebaseApiKey,
      appId: Config.firebaseAppId,
      messagingSenderId: Config.firebaseMessagingSenderId,
      projectId: Config.firebaseProjectId,
    ),
  );

  //initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  final bookBox = await Hive.openBox<Book>('books');
  // await bookBox.clear();

  print("Total books in hive: ${bookBox.values.length}");
  if (bookBox.isEmpty) {
    final books = await getInitialBooks();
    await bookBox.addAll(books);
    print("Seeded ${books.length} books into Hive");
  } else {
    print("Books already exist. Skipping seeding.");
  }

  runApp(
    KhaltiScope(
      publicKey: Config.khaltiPublicKey, // Khalti public key
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
  //to print the user info
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

      initialRoute: '/',
      routes: {
        '/':
            (context) =>
                Homepage(onThemeChanged: toggleTheme, body: Mainbody(), footer: FooterSection()),
        '/cinematic':
            (context) => cinematicpage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/bestsellers':
            (context) => bestSellersPage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/newarrivals':
            (context) => NewArrivalsPage(onThemeChanged: toggleTheme, footer: FooterSection()),
        '/author-books': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String?;
          return AuthorBooksPage(
            authorName: args ?? '',
            onThemeChanged: toggleTheme,
            footer: FooterSection(),
          );
        },
        '/admin': (context) => AdminBookUploadPage(),
        '/usercart':
            (context) => ShoppingCartPage(
              //onThemeChanged: toggleTheme,
              //footer: FooterSection(),
            ),
        '/aboutus': (context) => AboutAndContactPage(),
        '/payment-success': (context) => PaymentSuccessPage(),
        '/payment-failure': (context) => PaymentFailurePage(),

        // Add more routes here if needed
      },
    );
  }
}
