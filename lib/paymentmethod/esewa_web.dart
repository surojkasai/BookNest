// booknest/paymentmethod/esewa_web.dart
import 'dart:convert'; // Might not be directly used here if just opening URL
import 'dart:html' as html; // For web-specific window.open
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // If you plan to use backend for Esewa initiation

class EsewaPayment extends StatefulWidget {
  final String amount;
  final String merchantCode;
  final String productId;
  final String successUrl;
  final String failureUrl;

  const EsewaPayment({
    super.key,
    required this.amount,
    required this.merchantCode,
    required this.productId,
    required this.successUrl,
    required this.failureUrl,
  });

  @override
  State<EsewaPayment> createState() => _EsewaPaymentState();
}

class _EsewaPaymentState extends State<EsewaPayment> {
  @override
  void initState() {
    super.initState();
    // Automatically initiate payment when this page is loaded (for web)
    _initiateEsewaPayment();
  }

  Future<void> _initiateEsewaPayment() async {
    // Esewa generally expects amount in paisa (smallest unit)
    // Confirm this with Esewa's documentation. If your 'amount' is already in paisa,
    // then no conversion needed here. If it's in Rupees, convert it.
    // Example: If widget.amount is "100" (for Rs. 100), convert to "10000" (10000 paisa)
    // For now, let's assume widget.amount is already in Rupees.
    final double amountInRupees = double.parse(widget.amount);
    final int amountInPaisa =
        (amountInRupees * 100).toInt(); // Or whatever conversion Esewa needs for 'tAmt'

    // Define all parameters as per Esewa's API.
    // This example uses the parameters for direct POST submission as specified in some Esewa docs.
    // You MUST verify these parameter names and values with the official Esewa documentation.
    final Map<String, String> params = {
      'amt': amountInRupees.toStringAsFixed(2), // Original amount without charges/taxes
      'pdc': '0', // Product Delivery Charge
      'psc': '0', // Product Service Charge
      'txAmt': '0', // Tax Amount
      'tAmt': amountInRupees.toStringAsFixed(
        2,
      ), // Total Amount (This is crucial, should match 'amt' if no extra charges)
      'scd': widget.merchantCode, // Merchant Code
      'pid': widget.productId, // Product/Order ID
      'su': widget.successUrl, // Success URL
      'fu': widget.failureUrl, // Failure URL
    };

    // Construct the query string for a GET request (simpler for direct URL launch)
    // Or, prepare for a POST request.
    // Esewa often uses a POST form submission.

    // === Method 1: Programmatically creating and submitting a POST form (More robust for Esewa) ===
    // This is generally preferred for Esewa as it handles POST data directly.
    final String esewaEndpoint =
        'https://rc-epay.esewa.com.np/api/epay/main/v2/form'; // Sandbox URL
    // Use 'https://epay.esewa.com.np/api/epay/main/v2/form' for production

    try {
      // Create a hidden HTML form
      final html.FormElement form =
          html.FormElement()
            ..action = esewaEndpoint
            ..method = 'POST'
            ..target = '_blank'; // Open in a new tab

      // Add input fields for each parameter
      params.forEach((key, value) {
        form.children.add(
          html.InputElement()
            ..name = key
            ..value = value
            ..type = 'hidden',
        ); // Hidden inputs
      });

      // Append form to the document body and submit it
      html.document.body?.append(form);
      form.submit();
      form.remove(); // Remove the form after submission

      // You might want to show a loading indicator or a message to the user
      // informing them that they are being redirected to Esewa.
    } catch (e) {
      print('Error initiating Esewa payment: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to initiate Esewa payment: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Esewa Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text('Redirecting to Esewa...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Allow user to manually go back if redirect fails or they cancel
                Navigator.of(context).pop();
              },
              child: const Text('Cancel Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
