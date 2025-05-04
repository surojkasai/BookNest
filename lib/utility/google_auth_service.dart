// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// final GoogleSignIn googleSignIn = GoogleSignIn();
// final FirebaseAuth _auth = FirebaseAuth.instance;

// String? uid;
// String? name;
// String? userEmail;
// String? imageUrl;

// Future<User?> signinWithGoogle() async {
//   await Firebase.initializeApp();
//   User? user;

//   if (kIsWeb) {
//     GoogleAuthProvider authProvider = GoogleAuthProvider();

//     try {
//       final UserCredential userCredential = await _auth.signInWithPopup(
//         authProvider,
//       );

//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         print('The account already exists with a different credential.');
//       } else if (e.code == 'invalid-credential') {
//         print('Error occurred while accessing credentials. Try again.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   } else {
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential = await _auth.signInWithCredential(
//           credential,
//         );

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           print('The account already exists with a different credential.');
//         } else if (e.code == 'invalid-credential') {
//           print('Error occurred while accessing credentials. Try again.');
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   if (user != null) {
//     uid = user.uid;
//     name = user.displayName;
//     userEmail = user.email;
//     imageUrl = user.photoURL;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('auth', true);
//   }

//   return user;
// }

// void sigOutGoogle() async {
//   await googleSignIn.signOut();
//   await _auth.signOut();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('auth', false);

//   uid = null;
//   name = null;
//   userEmail = null;
//   imageUrl = null;

//   print("User signed out of Google account");
// }

// /// Define a new function called getUser to retrieve the user's information if they have already logged in previously:
// Future getUser() async {
//   // Initialize Firebase
//   await Firebase.initializeApp();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool authSignedIn = prefs.getBool('auth') ?? false;

//   final User? user = _auth.currentUser;

//   if (authSignedIn == true) {
//     if (user != null) {
//       uid = user.uid;
//       name = user.displayName;
//       userEmail = user.email;
//       imageUrl = user.photoURL;
//     }
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   static final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       //'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );

//   static Future<GoogleSignInAccount?> signIn() async {
//     try {
//       return await _googleSignIn.signIn();
//     } catch (e) {
//       debugPrint("Google Sign-In error: $e");
//       return null;
//     }
//   }

//   static Future<void> signOut() => _googleSignIn.disconnect();

//   static GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

//   static Future<bool> isAuthorized() async {
//     if (kIsWeb && currentUser != null) {
//       return await _googleSignIn.canAccessScopes([
//         'email',
//         //'https://www.googleapis.com/auth/contacts.readonly',
//       ]);
//     }
//     return currentUser != null;
//   }

//   static Future<void> signInSilently() async {
//     await _googleSignIn.signInSilently();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<User?> signIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 🔐 Sign in to Firebase with the Google credentials
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return userCredential.user;
    } catch (e) {
      debugPrint("Google Sign-In error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  static GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}
