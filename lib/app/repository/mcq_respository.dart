// REPOSITORY TO GET ALL MCQ

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class McqRepository {
  Future<ApiResponse<McqApiResponse>> getAllMcq() async {
    final response = await ApiClient().getApi<McqApiResponse>(
      ApiEndpoints.getAllMcq,
      isTokenRequired: false,
      responseType: (json) => McqApiResponse.fromJson(json),
    );

    return response;
  }
}
