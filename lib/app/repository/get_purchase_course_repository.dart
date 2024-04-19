// REPOSITORY TO GET THE PURCHASE COURSE  BY STUDENT

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/my_course_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetPurchaseCourseRepository {
  Future<ApiResponse<MyCourseResponse>> getPurchasedCouse() async {
    final response = await ApiClient().getApi<MyCourseResponse>(
      ApiEndpoints.getPurchaseCourse,
      isTokenRequired: true,
      responseType: (json) => MyCourseResponse.fromJson(json),
    );

    return response;
  }
}
