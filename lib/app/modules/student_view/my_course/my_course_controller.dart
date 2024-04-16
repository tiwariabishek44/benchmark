import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/my_course_response.dart';
import 'package:benchmark/app/repository/get_purchase_course_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyCourseController extends GetxController {
  final storage = GetStorage();
  var isLoading = false.obs;
  var courseLoaded = false.obs;
//-------------GET STUDENT PURCHASAE COURSE ------------
  final myCourseRepository = Get.put(GetPurchaseCourseRepository());
  final Rx<ApiResponse<MyCourseResponse>> myCourseResponse =
      ApiResponse<MyCourseResponse>.initial().obs;

  Future<void> getPurchaseCourse() async {
    try {
      log(" -------------TYR OT GETTING PURCHASE COURSE ");
      isLoading(true);
      courseLoaded(false);
      myCourseResponse.value = ApiResponse<MyCourseResponse>.loading();
      final courseResult = await myCourseRepository.getPurchasedCouse();
      if (courseResult.status == ApiStatus.SUCCESS) {
        myCourseResponse.value =
            ApiResponse<MyCourseResponse>.completed(courseResult.response);
        if (myCourseResponse.value.response!.data.isNotEmpty) {
          log(" ${myCourseResponse.value.response!.data.length}");
          log(myCourseResponse.value.response!.data.toString());
          courseLoaded(true);
        }
        isLoading(false);
      } else {
        CustomSnackBar.showFailure('Some Thing went wrong');
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      CustomSnackBar.showFailure('$e');
    }
  }
}
