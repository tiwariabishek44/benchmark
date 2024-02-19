import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetCourseRepository {
  Future<ApiResponse<CourseResponse>> getAllNotes(String courseName) async {
    log(courseName);
    final response = await ApiClient().getApi<CourseResponse>(
      "${ApiEndpoints.getAllNotes}${courseName}",
      responseType: (json) => CourseResponse.fromJson(json),
    );

    return response;
  }
}
