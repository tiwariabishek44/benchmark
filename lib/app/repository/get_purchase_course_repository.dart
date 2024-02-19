import 'package:benchmark/app/model/api_response/student_purchase_course_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetPurchaseCourseRepository {
  Future<ApiResponse<StudentPurchaseCourseResponse>> getPurchasedCouse(
      String endpoint) async {
    final response = await ApiClient().getApi<StudentPurchaseCourseResponse>(
      endpoint,
      isTokenRequired: true,
      responseType: (json) => StudentPurchaseCourseResponse.fromJson(json),
    );

    return response;
  }
}
