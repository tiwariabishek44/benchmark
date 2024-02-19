import 'package:benchmark/app/model/api_response/user_data_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetUserDataRepository {
  Future<ApiResponse<GetUserDataResponse>> getuserData(String endpoint) async {
    final response = await ApiClient().getApi<GetUserDataResponse>(
      endpoint,
      responseType: (json) => GetUserDataResponse.fromJson(json),
    );

    return response;
  }
}
