import 'dart:typed_data';

import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get subtotal {
    double total = 0;
    for (var item in _items) {
      total += (item["price"] as int) * (item["quantity"] as int);
    }
    return total;
  }

  void addItem(String title, String author, double price, Uint8List? image) {
    final existingIndex = _items.indexWhere((item) => item['title'] == title);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity']++;
    } else {
      _items.add({"title": title, "author": author, "price": price, "quantity": 1, "image": image});
    }
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _items[index]["quantity"]++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_items[index]["quantity"] > 1) {
      _items[index]["quantity"]--;
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

//new
// import 'package:flutter/material.dart';
// import 'dart:typed_data'; // Import for Uint8List

// class CartProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _items = [];

//   List<Map<String, dynamic>> get items => _items;

//   double get subtotal {
//     double total = 0;
//     for (var item in _items) {
//       // Ensure "price" is treated as a double to avoid potential issues
//       // if it was stored as int and then a non-integer price comes in.
//       total += (item["price"] as double) * (item["quantity"] as int);
//     }
//     return total;
//   }

//   // Modified addItem method to accept Uint8List? for the image
//   void addItem(String title, String author, double price, Uint8List? imageBytes) {
//     final existingIndex = _items.indexWhere((item) => item['title'] == title);
//     if (existingIndex != -1) {
//       _items[existingIndex]['quantity']++;
//     } else {
//       // Store imageBytes directly in the item map
//       _items.add({
//         "title": title,
//         "author": author,
//         "price": price,
//         "quantity": 1,
//         "imageBytes": imageBytes, // Changed from "image" to "imageBytes"
//       });
//     }
//     notifyListeners();
//   }

//   void increaseQuantity(int index) {
//     if (index >= 0 && index < _items.length) {
//       // Add boundary check
//       _items[index]["quantity"]++;
//       notifyListeners();
//     }
//   }

//   void decreaseQuantity(int index) {
//     if (index >= 0 && index < _items.length) {
//       // Add boundary check
//       if (_items[index]["quantity"] > 1) {
//         _items[index]["quantity"]--;
//         notifyListeners();
//       } else {
//         // Optionally remove item if quantity drops to 0 or less
//         removeItem(index);
//       }
//     }
//   }

//   void removeItem(int index) {
//     if (index >= 0 && index < _items.length) {
//       // Add boundary check
//       _items.removeAt(index);
//       notifyListeners();
//     }
//   }

//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
// }
