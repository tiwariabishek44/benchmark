import 'dart:developer';
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

  var selectedValue =
      'Science'.obs; // This will hold the selected dropdown value

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void registerUser(BuildContext context) {
    if (registerFromkey.currentState!.validate()) {
      if (termsAndConditions.value) {
        log(' this si the register ');
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
      isregisterLoading(true);
      registerResponse.value = ApiResponse<RegisterResponseModel>.loading();
      final user = {
        'name': namecontroller.value.text.trim(),
        "email": emailcontroller.value.text.trim(),
        "phone": phonenocontroller.value.text.trim(),
        "password": passwordcontroller.value.text.trim(),
        "isVerified": loginOptionController.isUser.value ? true : false,
        "userType": loginOptionController.isUser.value ? "student" : "teacher",
        "stream": selectedValue.value.toString(),
      };
      log('-------------------------user data-------------');
      final registerResult = await registerRepository.registerUser(user);
      // log(registerResult.status.toString());

      if (registerResult.status == ApiStatus.SUCCESS) {
        registerResponse.value = ApiResponse<RegisterResponseModel>.completed(
            registerResult.response);
        // Navigate to home page or perform necessary actions upon successful login
        CustomSnackBar.showSuccess('User Register Success');
        Get.back();
        isregisterLoading(false);
      } else {
        CustomSnackBar.showSuccess('User Register Success');
        isregisterLoading(false);
      }
    } catch (e) {
      isregisterLoading(false);

      log("thi is error $e");
    }
  }

  String? usernameValidator(String? value) {
    // if(fieldLostFocus == usernameController.hashCode)
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
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
      return 'This field is required';
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
      return 'Phone no must be  10 digits';
    }
    // Check for additional criteria (e.g., at least one digit and one special character)

    return null; // Return null if the password meets the criteria
  }

  void clearTextControllers() {
    emailcontroller.clear();
    namecontroller.clear();
    phonenocontroller.clear();
    passwordcontroller.clear();
  }
}
