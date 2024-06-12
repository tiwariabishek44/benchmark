import 'dart:convert';

import 'package:benchmark/app/modules/common/note_purchase/note_purchase_controller.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart'; 
import 'package:http/http.dart' as http;

class Esewa {
  String client_id = dotenv.get('ESEWA_CLIENT_ID');
  String secete_key = dotenv.get('ESEWA_SECRET_KEY');

  final purchaseController = Get.put(PurchaseControler());
  pay(String courseId, String price, String courseName) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: client_id,
          secretId: secete_key,
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
      String basicAuth = 'Basic ${base64.encode(utf8.encode(client_id))}';

      Map<String, String> headers = {
        'Authorization': basicAuth,
        'merchantId': client_id,
        'merchantSecret': secete_key,
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
