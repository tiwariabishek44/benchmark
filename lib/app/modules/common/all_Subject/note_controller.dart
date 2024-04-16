import 'dart:developer';

import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/repository/ger_course_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  var selectedTopic = 0.obs;

  var isLoading = false.obs;
  var noteLoaded = false.obs;

  final GetCourseRepository courseRepository = GetCourseRepository();

  final Rx<ApiResponse<McqApiResponse>> courseResponse =
      ApiResponse<McqApiResponse>.initial().obs;
  Future<void> fetchAllNotes(
      String stream, String garde, String subject) async {
    try {
      log("--fetching the notes");
      noteLoaded(false);
      isLoading(true);

      final courseInfo = {"grade": garde, "stream": stream, "subject": subject};
      courseResponse.value = ApiResponse<McqApiResponse>.loading();
      final courseResult = await courseRepository.getAllNotes(courseInfo);
      if (courseResult.status == ApiStatus.SUCCESS) {
        courseResponse.value =
            ApiResponse<McqApiResponse>.completed(courseResult.response);
        if (courseResponse.value.response!.data!.length != 0) {
          noteLoaded(true);
        }
        log(" this are all the list of the course ${courseResponse.value.response!.data!.length}");

        isLoading(false);
      } else {
        courseResponse.value = ApiResponse<McqApiResponse>.error(
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
