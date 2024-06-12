// REPOSITORY  TO GET THE COURSE

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/model/api_response/mannual_response_model.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetAllMannualRepository {
// TO GET THE Mannual OF THE COURSE
  Future<ApiResponse<MannualResponseModel>> getAllMannual(
      String subjectid) async {
    final response = await ApiClient().getApi<MannualResponseModel>(
      "${ApiEndpoints.getAllMannual}$subjectid",
      isTokenRequired: false,
      responseType: (json) => MannualResponseModel.fromJson(json),
    );

    return response;
  }
}
