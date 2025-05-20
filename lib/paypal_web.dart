import 'dart:html' as html;
import 'package:flutter/material.dart';

class PayPalTestButton extends StatelessWidget {
  final String url;

  const PayPalTestButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        html.window.open(url, '_blank');
      },
      child: Text('Pay with PayPal (Test)'),
    );
  }
}
