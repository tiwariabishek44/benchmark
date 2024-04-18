import 'dart:developer';
import 'package:benchmark/app/model/api_response/otp_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/common/register/otp_verification.dart';
import 'package:benchmark/app/repository/otp_verify_repository.dart';
import 'package:flutter/material.dart';
import 'package:benchmark/app/model/api_response/register_response_model.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/repository/RegisterRepository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final storage = GetStorage();
  final loginOptionController = Get.put(
      LoginOptionController()); // TextEditingController for the email field
  final emailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final phonenocontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final storeNamecontroller = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final termsAndConditions = false.obs;
  final isregisterLoading = false.obs;
  final registerFromkey = GlobalKey<FormState>();
  final isPasswordVisible = false.obs;
  final cornfirmPasswordVisible = false.obs;
  var otpPin = ''.obs;

  var selectedValue =
      'SCIENCE'.obs; // This will hold the selected dropdown value

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  void registerUser(BuildContext context) {
    if (registerFromkey.currentState!.validate()) {
      if (termsAndConditions.value) {
        register(context);

        // registerUsers();
      } else {
        CustomSnackBar.showFormFailure(
            'Please agree to the terms and conditions!');
      }
    } else {}
  }

  final UserRegisterRepository registerRepository = UserRegisterRepository();
  final Rx<ApiResponse<RegisterResponseModel>> registerResponse =
      ApiResponse<RegisterResponseModel>.initial().obs;

  Future<void> register(BuildContext context) async {
    try {
      log(" this isthe ${loginOptionController.isUser.value ? "STUDENT" : "TEACHER"}");

      isregisterLoading(true);
      registerResponse.value = ApiResponse<RegisterResponseModel>.loading();
      final user = {
        "email": emailcontroller.text.trim(),
        "phoneNumber": phonenocontroller.text.trim(),
        "name": namecontroller.text.trim(),
        "password": passwordcontroller.text.trim(),
        "accountType":
            loginOptionController.isUser.value ? "STUDENT" : "TEACHER",
        "stream": selectedValue.value
      };

      log(" this is user ${user}");

      final registerResult = await registerRepository.registerUser(user);
      // log('-------------------------user data-------------');

      if (registerResult.status == ApiStatus.SUCCESS) {
        registerResponse.value = ApiResponse<RegisterResponseModel>.completed(
            registerResult.response);
        // log('-----s' + registerResult.status.toString());
        // Navigate to home page or perform necessary actions upon successful login
        Get.to(() => OtpVerification(
              token: registerResponse.value.response!.data!.otpToken.toString(),
            ));
        isregisterLoading(false);
      } else {
        CustomSnackBar.authShowFailure(registerResult.message.toString());
        isregisterLoading(false);
      }
    } catch (e) {
      isregisterLoading(false);

      log("thi is error $e");
    }
  }
//----------------VERIFY OTP -----------

  void verify(BuildContext context, String token) {
    // log(otpPin.value + " this is the otp and token      ----" + token);
    otpVerify(context, token);
  }

  final OtpVerifyRepository verifyRepository = OtpVerifyRepository();
  final Rx<ApiResponse<OtpResponse>> otpResponse =
      ApiResponse<OtpResponse>.initial().obs;

  var isOtpVerify = false.obs;

  Future<void> otpVerify(BuildContext context, String token) async {
    try {
      isOtpVerify(true);
      otpResponse.value = ApiResponse<OtpResponse>.loading();
      final user = {"otp": otpPin.value.toString(), "otpToken": token};

      final verifyReult = await verifyRepository.verifyOtp(user);
      log(verifyReult.status.toString());
      // log('-------------------------user data-------------');

      if (verifyReult.status == ApiStatus.SUCCESS) {
        otpResponse.value =
            ApiResponse<OtpResponse>.completed(verifyReult.response);
        // log('-----s' + registerResult.status.toString());
        // Navigate to home page or perform necessary actions upon successful login
        Get.offAll(() => LoginOptionView());
        CustomSnackBar.showSuccess("User Account Create ");

        isOtpVerify(false);
      } else {
        CustomSnackBar.showSuccess(verifyReult.message.toString());
        isOtpVerify(false);
      }
    } catch (e) {
      isOtpVerify(false);

      log("thi is error $e");
    }
  }

  String? usernameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Check if the username contains only alphanumeric characters

    // Return null if the entered username is valid
    return null;
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

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the Confirm Password';
    }
    if (value != passwordcontroller.value.text) {
      return 'Confimation password does not match the entered password';
    }

    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone no';
    }
    if (value.length != 10) {
      return 'Phone no must be 10 digits';
    }
    // Additional criteria (if needed) can be checked here
    // For example, you can check if all characters are digits

    // Validate if all characters are digits
    if (!value.runes.every((rune) => rune >= 48 && rune <= 57)) {
      return 'Phone no must contain only digits';
    }

    return null; // Return null if the phone number meets the criteria
  }

  void clearTextControllers() {
    emailcontroller.clear();
    namecontroller.clear();
    phonenocontroller.clear();
    passwordcontroller.clear();
  }
}
