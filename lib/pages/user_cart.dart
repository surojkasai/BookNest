import 'dart:convert';
import 'dart:html' as html;
import 'package:booknest/paymentmethod/esewa_web.dart';
import 'package:http/http.dart' as http;
import 'package:js/js_util.dart' as js_util;

import 'package:booknest/paymentmethod/khalti_web.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
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
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final subtotal = cartProvider.subtotal + (isGift ? 15 : 0);

    // final subtotal = cartProvider.subtotal + (isGift ? 15 : 0);
    final usdAmount = (subtotal / 132).toStringAsFixed(2); // adjust exchange rate if needed
    final String testPaymentUrl =
        'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick'
        '&business=sb-merchant@example.com'
        '&item_name=Booknest+Order'
        '&amount=$usdAmount'
        '&currency_code=USD';
    final int amount = (subtotal * 100).toInt();
    return Homepage(
      //appBar: AppBar(title: const Text("Shopping Cart")),
      body: SingleChildScrollView(
        child: Padding(
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
                                        onPressed: () => decreaseQuantity(cartProvider, index),
                                      ),
                                      Text("${item["quantity"]}"),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () => increaseQuantity(cartProvider, index),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () => removeItem(cartProvider, index),
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
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text("Subtotal:"), Text("Rs. $subtotal")],
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
                        const Text("+ Rs. 15 for gift wrap", style: TextStyle(fontSize: 12)),
                      const Divider(height: 30),
                      const Text(
                        "Have a discount coupon? Apply it in the next step.",
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //   if (kIsWeb) {
                      //     html.window.open(testPaymentUrl, '_blank');
                      //   } else {
                      //     // Optional: show message or handle differently for mobile/desktop
                      //     print('This feature is only available on web.');
                      //   }
                      // },
                      //     child: const Text("PROCEED TO CHECKOUT"),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      const Text("Payment Options:"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        children: [
                          // Image.asset('assets/images/paypal.png', height: 50),
                          // Image.asset('assets/images/khalti.png', height: 50),
                          IconButton(
                            onPressed: () {
                              if (kIsWeb) {
                                html.window.open(testPaymentUrl, '_blank');
                              } else {
                                print('This feature is only available on web.');
                              }
                            },
                            icon: Image.asset('assets/images/paypal.png', height: 50),
                          ),
                          //khalti payment needs a proper backend because khalti need a pdix and return a back url when trying to initiate payment
                          IconButton(
                            onPressed: () async {
                              if (kIsWeb) {
                                // Call your backend API here to get payment_url
                                final response = await http.post(
                                  Uri.parse('http://localhost:5279/api/khaltipayment/initiate'),
                                  headers: {'Content-Type': 'application/json'},
                                  body: jsonEncode({
                                    "returnUrl":
                                        "http://localhost:7357/verify", // or your real return URL
                                    "websiteUrl": "http://localhost:7357",
                                    "amount": amount,
                                    "orderId": "ORDER123",
                                    "orderName": "Test Book Order",
                                    "customerName": "Test User",
                                    "customerEmail": "test@example.com",
                                    "customerPhone": "9800000000",
                                  }),
                                );

                                if (response.statusCode == 200) {
                                  try {
                                    print("RAW RESPONSE BODY:\n${response.body}");
                                    final decoded = jsonDecode(response.body);
                                    final paymentUrl =
                                        decoded['payment_url'] ?? (decoded['data']?['payment_url']);

                                    if (paymentUrl is String && paymentUrl.startsWith('http')) {
                                      html.window.open(paymentUrl, '_blank'); // open in new tab
                                    } else {
                                      throw Exception('Payment URL missing or invalid');
                                    }
                                  } catch (e) {
                                    print("Error during payment URL launch: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Payment URL not found or invalid')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Payment initiation failed')),
                                  );
                                }
                              }
                            },
                            icon: Image.asset('assets/images/khalti.png', height: 50),
                          ),

                          //esewa currently doesnot support flutter web
                          // IconButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder:
                          //             (_) => EsewaPayment(
                          //               amount: subtotal.toStringAsFixed(2),
                          //               merchantCode: 'EPAYTEST',
                          //               productId:
                          //                   'ORDER_${DateTime.now().millisecondsSinceEpoch}', // Generate a unique order ID
                          //               successUrl:
                          //                   'http://localhost:7357/#/payment-success', // Your web success URL
                          //               failureUrl: 'http://localhost:7357/#/payment-failure',
                          //             ),
                          //       ),
                          //     );
                          //   },
                          //   icon: Image.asset('assets/images/esewa.webp', height: 50),
                          // ),
                          // IconButton(
                          //   onPressed: () async {
                          //     if (kIsWeb) {
                          //       // Calculate total amount to send to backend (in Rupees, for Esewa)
                          //       final double totalAmountForEsewa =
                          //           subtotal as double; // subtotal is already in Rupees

                          //       try {
                          //         final response = await http.post(
                          //           Uri.parse(
                          //             'http://localhost:5279/api/esewapayment/initiate',
                          //           ), // <--- CALL YOUR NEW ESEWA BACKEND ENDPOINT
                          //           headers: {'Content-Type': 'application/json'},
                          //           body: jsonEncode({
                          //             "amount": totalAmountForEsewa,
                          //             "productId":
                          //                 "BOOKNEST_ORDER_${DateTime.now().millisecondsSinceEpoch}",
                          //             "successUrl":
                          //                 "http://localhost:7357/#/payment-success", // Your Flutter Web route
                          //             "failureUrl":
                          //                 "http://localhost:7357/#/payment-failure", // Your Flutter Web route
                          //             // Add customer info if your backend Esewa DTO requires it
                          //           }),
                          //         );

                          //         if (response.statusCode == 200) {
                          //           final responseData = jsonDecode(response.body);
                          //           final String? paymentUrl = responseData['payment_url'];

                          //           if (paymentUrl != null && paymentUrl.startsWith('http')) {
                          //             html.window.open(
                          //               paymentUrl,
                          //               '_blank',
                          //             ); // Open Esewa URL in new tab
                          //           } else {
                          //             throw Exception(
                          //               'Esewa Payment URL missing or invalid from backend: ${responseData['error_message']}',
                          //             );
                          //           }
                          //         } else {
                          //           // Handle backend error
                          //           final errorBody = await response.body;
                          //           print(
                          //             "Esewa Backend Error: ${response.statusCode} - $errorBody",
                          //           );
                          //           ScaffoldMessenger.of(context).showSnackBar(
                          //             SnackBar(
                          //               content: Text(
                          //                 'Esewa payment initiation failed: ${errorBody}',
                          //               ),
                          //             ),
                          //           );
                          //         }
                          //       } catch (e) {
                          //         print("Error initiating Esewa payment: $e");
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(content: Text('Failed to initiate Esewa payment: $e')),
                          //         );
                          //       }
                          //     } else {
                          //       // Handle non-web platforms if needed (e.g., use esewa_flutter package for mobile)
                          //       print(
                          //         'Esewa integration is currently web-only or requires mobile-specific setup.',
                          //       );
                          //     }
                          //   },
                          //   icon: Image.asset(
                          //     'assets/images/esewa.webp',
                          //     height: 50,
                          //   ), // Ensure you have an esewa.png image
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
      ),
      footer: FooterSection(),
    );
  }
}
