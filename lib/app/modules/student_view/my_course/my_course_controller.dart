import 'dart:developer';
import 'dart:html';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/student_purchase_course_response.dart';
import 'package:benchmark/app/repository/get_purchase_course_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyCourseController extends GetxController {
  final storage = GetStorage();
  var isLoading = false.obs;
//-------------GET STUDENT PURCHASAE COURSE ------------
  final userDataRepository = Get.put(GetPurchaseCourseRepository());
  final Rx<ApiResponse<StudentPurchaseCourseResponse>> userDataResponse =
      ApiResponse<StudentPurchaseCourseResponse>.initial().obs;

  Future<void> getUserData() async {
    try {
      userDataResponse.value =
          ApiResponse<StudentPurchaseCourseResponse>.loading();
      final userDataResult = await userDataRepository.getPurchasedCouse(
          "${ApiEndpoints.getPurchaseCourse}/${storage.read(userId)}");
      if (userDataResult.status == ApiStatus.SUCCESS) {
        log(" ----COURSE FETCH SUCCESFULL");

        userDataResponse.value =
            ApiResponse<StudentPurchaseCourseResponse>.completed(
                userDataResult.response);
      } else {
        CustomSnackBar.showFailure('Some Thing went wrong');
        isLoading(false);
      }
    } catch (e) {
      CustomSnackBar.showFailure('$e');
    }
  }
}
