import 'dart:developer';

import 'package:benchmark/app/model/api_response/course_buy_response.dart';
import 'package:benchmark/app/model/api_response/inquiry_response.dart';
import 'package:benchmark/app/repository/inquiry_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class InquiryController extends GetxController {
  var isInquiryLoading = false.obs;
  var inquiryResponse = ApiResponse<InquiryResponse>.initial().obs;
  final inquiryRepo = InquiryRepository();

  Future<void> userInquiry({
    required String productName,
    required String price,
    required String studentName,
    required String phone,
  }) async {
    isInquiryLoading.value = true;

    final body = {
      'productName': productName,
      'price': price,
      'sudentName': studentName,
      'phone': phone,
    };
    log(body.toString());

    try {
      final response = await inquiryRepo.inquiry(body);
      inquiryResponse.value = response;

      //==============Observe the API Response ===========
      if (response.status == ApiStatus.SUCCESS) {
        log("Course Buy SUCCESSFUL API CALL");
        CustomSnackBar.showSuccess('Successfully Course Buy');
      } else {
        CustomSnackBar.showFailure('${response.message}');
      }
    } catch (e) {
      log("Error occurred: $e");
      CustomSnackBar.showFailure('Error occurred: $e');
    } finally {
      isInquiryLoading.value = false;
    }
  }
}
