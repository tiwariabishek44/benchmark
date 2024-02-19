import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/udate_userdata_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class UpdateUserDataRepository {
  Future<ApiResponse<UdpateUserDataResponse>> updateUserData(
      String userId, requesBody) async {
    final response = await ApiClient().putApi<UdpateUserDataResponse>(
      '${ApiEndpoints.userDetailUpdate}/${userId.toString()}',
      requestBody: requesBody,
      responseType: (json) => UdpateUserDataResponse.fromJson(json),
    );
    return response;
  }
}
