import 'dart:developer';
import 'dart:io';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/login_response_model.dart';
import 'package:benchmark/app/services/api_client.dart';

class LoginRepository {
  Future<ApiResponse<LoginResponseModel>> loginUser(requesBody) async {
    log(" INSIDE THE LOGIN REPOSITORY");
    final response = await ApiClient().postApi<LoginResponseModel>(
      ApiEndpoints.userLogin,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => LoginResponseModel.fromJson(json),
    );

    return response;
  }
}
