import 'dart:developer';

import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/homepage.dart';
import 'package:benchmark/app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  // TextEditingController for the email field
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final vendorCode = TextEditingController();

  var isloading = false.obs;
  final loginFromkey = GlobalKey<FormState>();
  final termsAndConditions = false.obs;
  final vendorLoginFromkey = GlobalKey<FormState>();

  void signin() {
    storage.write(isLogin, 'isLogin');
    Get.to(() => Homepage());
  }

  void logout() {
    storage.remove(isLogin);
    Get.offAll(SplashScreen());
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
    return null;
  }

  String? vendorVlidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Canteen Code';
    }

    // Return null if the entered email is valid
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for additional criteria (e.g., at least one digit and one special character)

    return null; // Return null if the password meets the criteria
  }
}
