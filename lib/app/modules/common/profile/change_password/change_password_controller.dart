import 'dart:developer';
import 'dart:io';

import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/chage_password_response.dart';
import 'package:benchmark/app/repository/chage_password_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangePasswordController extends GetxController {
  final storage = GetStorage();
  final fomkey = GlobalKey<FormState>();
  var obscureText = true.obs;
  var obscureText1 = true.obs;
  var obscureText2 = true.obs;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final cPasswordController = TextEditingController();
  var updateLodaing = false.obs;

  void changePasswordSubmit() {
    log("this is to war of re-------");
    if (fomkey.currentState!.validate()) {
      if (newPasswordController.text.trim() ==
          cPasswordController.text.trim()) {
        changepass();
      } else {
        CustomSnackBar.showFailure('Password Doesnot match');
      }
    } else {}
  }

//------------change the user password---------//
  final ChangePasswordRepository changePasswordRepository =
      ChangePasswordRepository();

  final Rx<ApiResponse<ChangePasswordResponse>> changePasswordResponse =
      ApiResponse<ChangePasswordResponse>.initial().obs;

  Future<void> changepass() async {
    try {
      updateLodaing(true);
      changePasswordResponse.value =
          ApiResponse<ChangePasswordResponse>.loading();
      final changepassword = {
        "oldPassword": oldPasswordController.text.trim(),
        "newPassword": newPasswordController.text.trim(),
        "confirmPassword": cPasswordController.text.trim()
      };

      final changePasswordResult = await changePasswordRepository
          .changepassword(storage.read(userId), changepassword);
      if (changePasswordResult.status == ApiStatus.SUCCESS) {
        changePasswordResponse.value =
            ApiResponse<ChangePasswordResponse>.completed(
                changePasswordResult.response);
        log(" THS IS THE RESPONSE VALUE:${changePasswordResult.status}");
        // Navigate to home page or perform necessary actions upon successful login
        CustomSnackBar.showSuccess('Password update Succesfully');

        Get.back();
        updateLodaing(false);
      } else {
        changePasswordResponse.value =
            ApiResponse<ChangePasswordResponse>.error(
                changePasswordResult.message ??
                    'Error during product create Failed');
        updateLodaing(false);
      }
    } on SocketException {
      CustomSnackBar.showFailure("No Internet Connection");
    } catch (e) {
      CustomSnackBar.showFailure(
          "Something went wrong. Please try again later");
    }
  }
}
