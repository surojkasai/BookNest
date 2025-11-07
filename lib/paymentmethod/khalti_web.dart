import 'dart:js' as js;
import 'package:booknest/config.dart';
import 'package:flutter/material.dart';
import 'package:js/js_util.dart' as js_util;

void openKhaltiCheckout({
  required int amount,
  required String productIdentity,
  required String productName,
  required Function(dynamic payload) onSuccess,
  required Function(dynamic error) onError,
  required Function() onClose,
  required BuildContext context, // pass context for SnackBar
}) {
  final config = js.JsObject.jsify({
    "publicKey": Config.publicKey,
    "productIdentity": productIdentity,
    "productName": productName,
    "productUrl": "http://localhost/product/1234",
    "amount": amount,
    "paymentPreference": ["KHALTI", "EBANKING", "MOBILE_BANKING", "CONNECT_IPS", "SCT"],
    "additionalData": {
      "product_details": [
        {
          "identity": productIdentity,
          "name": productName,
          "total_price": amount,
          "quantity": 1,
          "unit_price": amount,
        },
      ],
    },
    "eventHandler": js.JsObject.jsify({
      "onSuccess": js.allowInterop(onSuccess),
      "onError": js.allowInterop((error) {
        final jsonString = js.context['JSON'].callMethod('stringify', [error]);
        print("Payment error JSON: $jsonString");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Payment Failed: $jsonString')));
        onError(error);
      }),
      "onClose": js.allowInterop(onClose),
    }),
  });

  final khaltiCheckout = js.JsObject(js.context['KhaltiCheckout'], [config]);
  khaltiCheckout.callMethod('show');
}
