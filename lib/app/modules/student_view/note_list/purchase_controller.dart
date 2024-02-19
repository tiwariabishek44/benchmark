import 'dart:developer';

import 'package:benchmark/app/model/api_response/course_buy_response.dart';
import 'package:benchmark/app/repository/course_buy_reopsitory.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class PurchaseControler extends GetxController {
  var purchaseLoading = false.obs;
  var purchaseResponse = ApiResponse<CourseBuyResponse>.initial().obs;
  final purchaseRepo = CourseBuyRepository();

  Future<void> buyCourse({
    required String courseId,
    required String courseName,
    required String price,
    required String studentName,
    required String uid,
    required String id,
    required String purchaseTime,
  }) async {
    purchaseLoading.value = true;

    final body = {
      'courseId': courseId,
      'courseName': courseName,
      'price': price,
      'sudentName': studentName,
      'uid': uid,
      'id': id,
      'purcahseTime': id.toString(),
    };
    log(body.toString());

    try {
      final response = await purchaseRepo.buyCourse(body);
      purchaseResponse.value = response;

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
      purchaseLoading.value = false;
    }
  }
}
