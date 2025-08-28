import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> verifyKhaltiPayment(String token, int amount) async {
  final url = Uri.parse('http://localhost:5000/api/khalti/verify');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'token': token, 'amount': amount}),
  );

  if (response.statusCode == 200) {
    // Payment verified successfully
    final data = jsonDecode(response.body);
    // You can process data here, e.g. check if status is completed, etc.
    return true;
  } else {
    // Verification failed
    return false;
  }
}
