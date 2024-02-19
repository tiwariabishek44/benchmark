import 'dart:developer';

import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/repository/ger_course_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CourseController extends GetxController {
  final storage = GetStorage();
  var isLoading = false.obs;
  var selectedTopics = 0.obs;

  final GetCourseRepository courseRepository = GetCourseRepository();

  @override
  void onInit() {
    super.onInit();
    // Fetch data only if the list is empty
  }

  final Rx<ApiResponse<CourseResponse>> courseResponse =
      ApiResponse<CourseResponse>.initial().obs;
  Future<void> fetchNotes(String courseName) async {
    try {
      isLoading(true);
      for (int i = 0; i < 100; i++) {
        log(i.toString());
      }
      courseResponse.value = ApiResponse<CourseResponse>.loading();
      final courseResult = await courseRepository.getAllNotes(courseName);
      if (courseResult.status == ApiStatus.SUCCESS) {
        courseResponse.value =
            ApiResponse<CourseResponse>.completed(courseResult.response);
        log("succesfully fetch data ${courseResponse.value.response?.notes.toString()}");
        isLoading(false);
      } else {
        courseResponse.value = ApiResponse<CourseResponse>.error(
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
