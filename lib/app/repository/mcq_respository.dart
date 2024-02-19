import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class McqRepository {
  Future<ApiResponse<McqResponse>> getAllMcq() async {
    final response = await ApiClient().getApi<McqResponse>(
      ApiEndpoints.getAllMcq,
      responseType: (json) => McqResponse.fromJson(json),
    );

    return response;
  }
}
