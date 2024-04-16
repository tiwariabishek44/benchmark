import 'dart:developer';

import 'package:benchmark/app/model/api_response/forget_password_response.dart';
import 'package:benchmark/app/modules/common/forget_password/new_password_page.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/repository/student%20repository/forget_password_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgetPasswordController extends GetxController {
  final storage = GetStorage();

//-------- FOR FROGET PASSWORD-------
  final forgetPasswordKey = GlobalKey<FormState>();
  final newPasswordKey = GlobalKey<FormState>();

  final emailoCntroller1 = TextEditingController();
  final newPasswordController = TextEditingController();
  var sendOtpLoading = false.obs;
  var otpError = true.obs;
  var otpPin = ''.obs;

  void sendOtp(BuildContext context) {
    if (forgetPasswordKey.currentState!.validate()) {
      firstStep();
    }
  }

  void changePassword(BuildContext context) {
    if (newPasswordKey.currentState!.validate()) {
      secondStep();
      // Get.offAll(() => LoginOptionView());
    }
  }

  final ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository();

//----------------------TO GET THE OTP FOR PASSWORD CHANGE-----------
  final Rx<ApiResponse<ForgetPasswordResponse>> firstStepresponse =
      ApiResponse<ForgetPasswordResponse>.initial().obs;

  Future<void> firstStep() async {
    try {
      sendOtpLoading(true);
      firstStepresponse.value = ApiResponse<ForgetPasswordResponse>.loading();
      final user = {
        "email": emailoCntroller1.value.text.trim(),
      };
      final firstStepResult = await forgetPasswordRepository.firstStep(user);
      // log(registerResult.status.toString());

      if (firstStepResult.status == ApiStatus.SUCCESS) {
        Get.to(() => NewPasswordPage(
              email: emailoCntroller1.text.trim(),
            ));

        sendOtpLoading(false);
      } else {
        sendOtpLoading.value = false;
        CustomSnackBar.showFailure(" ${firstStepResult.message}");
      }
    } catch (e) {
      sendOtpLoading(false);
    }
  }

//--------------------TO CHANGE THE USER ACOUNT PASSWORD ---------

  final Rx<ApiResponse<ForgetPasswordResponse>> secondStepResponse =
      ApiResponse<ForgetPasswordResponse>.initial().obs;

  Future<void> secondStep() async {
    try {
      log(" this is new password ${newPasswordController.text.trim()}");
      sendOtpLoading(true);
      secondStepResponse.value = ApiResponse<ForgetPasswordResponse>.loading();
      final body = {
        "email": emailoCntroller1.text.trim(),
        "newPassWord": newPasswordController.text.trim(),
        "otp": otpPin.value.toString()
      };
      final secondStepResult = await forgetPasswordRepository.secondStep(body);
      // log(registerResult.status.toString());

      if (secondStepResult.status == ApiStatus.SUCCESS) {
        CustomSnackBar.showSuccess("Password Change Succesfully");

        Get.offAll(() => LoginOptionView());

        sendOtpLoading(false);
      } else {
        sendOtpLoading.value = false;
        CustomSnackBar.showFailure(" ${secondStepResult.message}");
      }
    } catch (e) {
      sendOtpLoading(false);
    }
  }

//-------------VALIDATOR-----------------

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

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    emailoCntroller1.dispose();
    newPasswordController.dispose();

    super.onClose();
  }
}
