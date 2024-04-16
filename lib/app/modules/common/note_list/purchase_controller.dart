import 'dart:developer';

import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/model/api_response/course_buy_response.dart';
import 'package:benchmark/app/repository/course_buy_reopsitory.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:benchmark/app/widgets/payment_succesfull.dart';
import 'package:get/get.dart';

class PurchaseControler extends GetxController {
  var purchaseLoading = false.obs;
  var purchaseResponse = ApiResponse<CourseBuyResponse>.initial().obs;
  final purchaseRepo = CourseBuyRepository();

  Future<void> buyCourse({
    required String courseId,
    required String amount,
  }) async {
    purchaseLoading.value = true;

    final body = {"subjectId": courseId};

    try {
      final response = await purchaseRepo.buyCourse(body);
      purchaseResponse.value = response;

      //==============Observe the API Response ===========
      if (response.status == ApiStatus.SUCCESS) {
        log(" this is the payent");
        Get.to(
            () => PaymentSuccessPage(
                  amountPaid: amount,
                ),
            transition: Transition.rightToLeft,
            duration: duration);
      } else {
        CustomSnackBar.showFailure('${response.message}');
      }
    } catch (e) {
      log("Error occurred: $e");
      CustomSnackBar.showFailure('Error occurred: $e');
    }
  }
}
