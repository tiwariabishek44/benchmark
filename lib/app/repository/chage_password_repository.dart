import 'dart:io';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/chage_password_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class ChangePasswordRepository {
  Future<ApiResponse<ChangePasswordResponse>> changepassword(
    String uid,
    requesBody,
  ) async {
    final response = await ApiClient().postApi<ChangePasswordResponse>(
      '${ApiEndpoints.changePassword}/$uid/change-password',
      requestBody: requesBody,
      isTokenRequired: true,
      responseType: (json) => ChangePasswordResponse.fromJson(json),
    );

    return response;
  }
}
