import 'dart:convert';
import 'dart:developer';

import 'package:benchmark/app/config/eSewa.dart';
import 'package:benchmark/app/modules/common/note_list/purchase_controller.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Esewa {
  final purchaseController = Get.put(PurchaseControler());
  pay(String courseId, String price, String courseName) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kEsewaClientId,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: courseId,
          productName: courseName,
          productPrice: price,
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          verify(result, courseId, price);
        },
        onPaymentFailure: () {
          debugPrint('FAILURE');
        },
        onPaymentCancellation: () {
          debugPrint('CANCEL');
        },
      );
    } catch (e) {
      debugPrint('EXCEPTION');
    }
  }

  Future<void> verify(result, String courseId, String amount) async {
    try {
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R:BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ=='))}';

      Map<String, String> headers = {
        'Authorization': basicAuth,
        'merchantId': kEsewaClientId,
        'merchantSecret': kEsewaSecretKey,
      };

      Uri uri = Uri.parse('https://rc.esewa.com.np/mobile/transaction');
      Uri finalUri = uri.replace(queryParameters: {'txnRefId': result.refId});

      http.Response response = await http.get(finalUri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        purchaseController.buyCourse(courseId: courseId, amount: amount);
      }
    } catch (e) {
      print(e);
    }
  }
}
