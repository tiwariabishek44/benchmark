import 'dart:developer';
import 'dart:io';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/register_response_model.dart';
import 'package:benchmark/app/services/api_client.dart';

class UserRegisterRepository {
  Future<ApiResponse<RegisterResponseModel>> registerUser(requesBody) async {
    log(" INSIDE THE rEGISTER REPOSITORY");
    final response = await ApiClient().postApi<RegisterResponseModel>(
      ApiEndpoints.userRegister,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => RegisterResponseModel.fromJson(json),
    );

    return response;
  }
}
