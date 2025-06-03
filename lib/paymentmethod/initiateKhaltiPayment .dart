import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> initiateKhaltiPayment() async {
  final response = await http.post(
    Uri.parse('http://localhost:5279/api/khaltipayment/initiate'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "returnUrl": "http://localhost:7357/verify",
      "websiteUrl": "http://localhost:7357",
      "amount": 1000,
      "orderId": "ORDER123",
      "orderName": "Test Order",
      "customerName": "Test User",
      "customerEmail": "test@example.com",
      "customerPhone": "9800000000",
    }),
  );

  final responseData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    final String? paymentUrl = responseData['payment_url'];
    if (paymentUrl != null && await canLaunchUrl(Uri.parse(paymentUrl))) {
      await launchUrl(Uri.parse(paymentUrl), mode: LaunchMode.externalApplication);
    } else {
      print("Invalid or missing payment_url");
      print("Full response data: $responseData");
    }
  } else {
    print("Error from backend: ${response.body}");
  }
}
