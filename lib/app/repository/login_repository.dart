import 'dart:developer';
import 'dart:io';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/first_Login_response.dart';
import 'package:benchmark/app/model/api_response/login_api_response.dart';
import 'package:benchmark/app/model/api_response/teacher_login_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:get/get.dart';

class LoginRepository {
  //--------STUDENT FIRST LOGIN
  Future<ApiResponse<FirstLoginResponse>> firstLogin(requesBody) async {
    final response = await ApiClient().postApi<FirstLoginResponse>(
      ApiEndpoints.firstLogin,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => FirstLoginResponse.fromJson(json),
    );

    return response;
  }

//------------STUDENT SECOND LOGIN
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
