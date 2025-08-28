// import 'dart:js' as js;
// import 'dart:convert';

// import 'package:flutter/material.dart'; // add at top

// void openKhaltiCheckout({
//   required int amount,
//   required String productIdentity,
//   required String productName,
//   required Function(dynamic payload) onSuccess,
//   required Function(dynamic error) onError,
//   required Function() onClose,
// }) {
//   final config = js.JsObject.jsify({
//     "publicKey": "test_public_key_dc74e03e880b463e87b8586836e3e7f5",
//     "productIdentity": productIdentity,
//     "productName": productName,
//     "productUrl": "http://localhost/product/1234",
//     "amount": amount,
//     "eventHandler": js.JsObject.jsify({
//       "onSuccess": js.allowInterop(onSuccess),
//       "onError": js.allowInterop(onError),
//       "onClose": js.allowInterop(onClose),
//     }),
//   });

//   final khaltiCheckout = js.JsObject(js.context['KhaltiCheckout'], [config]);
//   khaltiCheckout.callMethod('show');
// }
import 'dart:js' as js;
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
    "publicKey": "95cb0e15cb6e4af28e0c060a92f5a138",
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
