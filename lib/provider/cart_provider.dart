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
