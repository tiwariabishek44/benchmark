import 'dart:io';

import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:benchmark/app/model/api_response/udate_userdata_response.dart';
import 'package:benchmark/app/model/api_response/user_data_response.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/repository/update_user_data_repository.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();
  final loginController = Get.find<LoginController>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  Rx<GetUserDataResponse?> selectData = Rx<GetUserDataResponse?>(null);

//---------UPDATE THE TEXTEDITING CONTROLLER VALUE----------------//
  void udateUserData(GetUserDataResponse userData) {
    selectData.value = userData;
  }
//

//----------UPDATE THE USER DATA ----------------

  final updateUserDataRepository = Get.put(UpdateUserDataRepository());

  final updateUserDataResponse =
      ApiResponse<UdpateUserDataResponse>.initial().obs;

  void updateUserData() {
    if (formKey.currentState!.validate()) {
      performUpdate();
    }
  }

  Future<void> performUpdate() async {
    updateUserDataResponse.value =
        ApiResponse<UdpateUserDataResponse>.loading();
    final userData = {
      "name": nameController.text.trim(),
      "mobileNumber": phoneNumberController.text.trim(),
      "email": emailController.text.trim(),
    };

    try {
      final updateDataResult = await updateUserDataRepository.updateUserData(
          storage.read(userId), userData);

      if (updateDataResult.status == ApiStatus.SUCCESS) {
        updateUserDataResponse.value =
            ApiResponse<UdpateUserDataResponse>.completed(
                updateDataResult.response);
        loginController.getUserData();
        CustomSnackBar.showSuccess("User update success");

        Get.back();
      } else {
        CustomSnackBar.showFailure("${updateDataResult.message}");
      }
    } on SocketException {
      CustomSnackBar.showFailure("No Internet Connection");
    } catch (e) {
      CustomSnackBar.showFailure(
          "Something went wrong. Please try again later");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
