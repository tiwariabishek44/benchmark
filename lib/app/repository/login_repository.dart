// LOGIN REPOSITORY  FOR TEACHER AND STUDENT

import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/login_api_response.dart';
import 'package:benchmark/app/model/api_response/teacher_login_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class LoginRepository {
//------------STUDENT  LOGIN
  Future<ApiResponse<LoginApiResponse>> loginUser(requesBody) async {
    log(" INSIDE THE LOGIN REPOSITORY");
    final response = await ApiClient().postApi<LoginApiResponse>(
      ApiEndpoints.secondLogin,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => LoginApiResponse.fromJson(json),
    );

    return response;
  }

//------------TEACHER LOGIN
  Future<ApiResponse<TeacherLoginResponse>> teacherLogin(requesBody) async {
    log(" INSIDE THE LOGIN REPOSITORY");
    final response = await ApiClient().postApi<TeacherLoginResponse>(
      ApiEndpoints.teacherLogin,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => TeacherLoginResponse.fromJson(json),
    );

    return response;
  }
}
