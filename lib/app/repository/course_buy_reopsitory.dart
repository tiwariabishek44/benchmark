// REPOSITORY TO BUY THE COURSE
import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/course_buy_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class CourseBuyRepository {
  Future<ApiResponse<CourseBuyResponse>> buyCourse(requesBody) async {
    final response = await ApiClient().postApi<CourseBuyResponse>(
      ApiEndpoints.buyCourse,
      requestBody: requesBody,
      isTokenRequired: true,
      responseType: (json) => CourseBuyResponse.fromJson(json),
    );

    return response;
  }
}
