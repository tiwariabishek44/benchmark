import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetCourseRepository {
  Future<ApiResponse<CourseApiResponse>> getallCourse() async {
    final response = await ApiClient().getApi<CourseApiResponse>(
      ApiEndpoints.getAllCourse,
      isTokenRequired: false,
      responseType: (json) => CourseApiResponse.fromJson(json),
    );

    return response;
  }

  Future<ApiResponse<McqApiResponse>> getAllNotes(requestbody) async {
    final response = await ApiClient().postApi<McqApiResponse>(
      ApiEndpoints.getAllNotes,
      isTokenRequired: false,
      requestBody: requestbody,
      responseType: (json) => McqApiResponse.fromJson(json),
    );

    return response;
  }
}
