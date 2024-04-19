// REPOSITROY FOR OTP VERIFICAITON

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/otp_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class OtpVerifyRepository {
  Future<ApiResponse<OtpResponse>> verifyOtp(requesBody) async {
    final response = await ApiClient().postApi<OtpResponse>(
      ApiEndpoints.registerPhase2,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => OtpResponse.fromJson(json),
    );

    return response;
  }
}
