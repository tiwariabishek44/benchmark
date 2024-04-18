import 'dart:developer';

import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/repository/ger_course_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CourseController extends GetxController {
  var isLoading = false.obs;
  var loded = false.obs;

  final GetCourseRepository courseRepository = GetCourseRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllCourse();
  }

  final Rx<ApiResponse<CourseApiResponse>> courseResponse =
      ApiResponse<CourseApiResponse>.initial().obs;
  Future<void> fetchAllCourse() async {
    try {
      log('inside the course controller');
      loded(false);
      isLoading(true);
      courseResponse.value = ApiResponse<CourseApiResponse>.loading();
      final courseResult = await courseRepository.getallCourse();
      if (courseResult.status == ApiStatus.SUCCESS) {
        courseResponse.value =
            ApiResponse<CourseApiResponse>.completed(courseResult.response);

        log(" this are all the list of the course ${courseResponse.value.response!.data!.length}");

        if (courseResponse.value.response!.data.isNotEmpty) {
          loded(true);
        }

        isLoading(false);
      } else {
        courseResponse.value = ApiResponse<CourseApiResponse>.error(
            courseResult.message ?? 'Error during Login');
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);

      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }
}
