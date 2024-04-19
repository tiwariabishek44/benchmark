// TO DISPLAY THE LIST OF THE PHYSICAL ITEMS

import 'dart:developer';

import 'package:benchmark/app/model/api_response/physical_items_response.dart';
import 'package:benchmark/app/repository/get_physical_items_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhysicalItemController extends GetxController {
  var selectedOption = ' '.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bookController = TextEditingController();
  var isMcqLoading = false.obs;
  var isloded = false.obs;
  //--------------Get physical items------------------

  final physicalItemRepository = Get.put(PhysicalItemRepository());
  final Rx<ApiResponse<PhysicalItemApiResponse>> physicalItemresponse =
      ApiResponse<PhysicalItemApiResponse>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    isloded(false);
    getPhysicalItems();
    log("-------physicalItmes  controler initilize");
  }

  Future<void> getPhysicalItems() async {
    try {
      isloded(false);

      isMcqLoading(true);
      physicalItemresponse.value =
          ApiResponse<PhysicalItemApiResponse>.loading();
      final itemsResult = await physicalItemRepository.getPhysicalItems();
      if (itemsResult.status == ApiStatus.SUCCESS) {
        physicalItemresponse.value =
            ApiResponse<PhysicalItemApiResponse>.completed(
                itemsResult.response);
        log("this is the length " +
            physicalItemresponse.value.response!.data.length.toString());

        if (physicalItemresponse.value.response!.data.length != 0) {
          isloded(true);
        }
        isMcqLoading(false);
      } else {
        CustomSnackBar.showFailure('${itemsResult.message.toString()}');
        log("${itemsResult.message}");
        isloded(false);
        isMcqLoading(false);
      }
    } catch (e) {
      // CustomSnackBar.showFailure('$e');
      log("${e.toString()}");

      isMcqLoading(false);
    }
  }

  String? itemValidarot(String? value) {
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
}
