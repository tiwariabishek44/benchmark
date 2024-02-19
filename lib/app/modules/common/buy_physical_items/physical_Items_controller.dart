import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/physical_items_response.dart';
import 'package:benchmark/app/repository/get_physical_items_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyItemController extends GetxController {
  var selectedOption = ' '.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bookController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  //--------------Get physical items------------------

  final physicalItemsRepository = Get.put(GetPhysicalItemsRepository());
  final Rx<ApiResponse<PhysicalItemsResponse>> itemsResponse =
      ApiResponse<PhysicalItemsResponse>.initial().obs;

  Future<void> getPhysicalItems() async {
    try {
      itemsResponse.value = ApiResponse<PhysicalItemsResponse>.loading();
      final itemsResult = await physicalItemsRepository.getPhysicalItems();
      if (itemsResult.status == ApiStatus.SUCCESS) {
        log(" ----Items FETCH SUCCESFULL");

        itemsResponse.value =
            ApiResponse<PhysicalItemsResponse>.completed(itemsResult.response);
      } else {
        CustomSnackBar.showFailure('Some Thing went wrong');
        isLoading(false);
      }
    } catch (e) {
      CustomSnackBar.showFailure('$e');
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
