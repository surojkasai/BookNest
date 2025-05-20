import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool isGift = false;

  void increaseQuantity(CartProvider cartProvider, int index) {
    cartProvider.increaseQuantity(index);
  }

  void decreaseQuantity(CartProvider cartProvider, int index) {
    cartProvider.decreaseQuantity(index);
  }

  void removeItem(CartProvider cartProvider, int index) {
    cartProvider.removeItem(index);
  }

  @override
  Widget build(BuildContext context) {
    final String testPaymentUrl =
        'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business=sb-merchant@example.com&item_name=Test+Item&amount=10.00&currency_code=USD';

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final subtotal = cartProvider.subtotal + (isGift ? 15 : 0);

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopping Cart (${cartItems.length})",
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  ...cartItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(item["image"], height: 120),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("by ${item["author"]}"),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed:
                                          () => decreaseQuantity(
                                            cartProvider,
                                            index,
                                          ),
                                    ),
                                    Text("${item["quantity"]}"),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed:
                                          () => increaseQuantity(
                                            cartProvider,
                                            index,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed:
                                          () => removeItem(cartProvider, index),
                                      child: const Text("Remove"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text("Add to Wishlist"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Rs. ${item["price"] * item["quantity"]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("< Continue Shopping"),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Right section
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal:"),
                        Text("Rs. $subtotal"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.card_giftcard),
                        const SizedBox(width: 8),
                        const Expanded(child: Text("Is this a gift?")),
                        Checkbox(
                          value: isGift,
                          onChanged: (val) {
                            setState(() {
                              isGift = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    if (isGift)
                      const Text(
                        "+ Rs. 15 for gift wrap",
                        style: TextStyle(fontSize: 12),
                      ),
                    const Divider(height: 30),
                    const Text(
                      "Have a discount coupon? Apply it in the next step.",
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (kIsWeb) {
                            html.window.open(testPaymentUrl, '_blank');
                          } else {
                            // Optional: show message or handle differently for mobile/desktop
                            print('This feature is only available on web.');
                          }
                        },
                        child: const Text("PROCEED TO CHECKOUT"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Payment Options:"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/khalti.png', height: 50),
                        // Image.asset('assets/images/connectips.png', height: 32),
                        // Image.asset('assets/images/stripe.png', height: 32),
                        // Image.asset(
                        //   'assets/images/cashondelivery.png',
                        //   height: 32,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
