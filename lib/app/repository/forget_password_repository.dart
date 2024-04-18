import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/forget_password_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class ForgetPasswordRepository {
  //--------FORGET PASSWORD FIRST STEP
  Future<ApiResponse<ForgetPasswordResponse>> firstStep(requesBody) async {
    final response = await ApiClient().postApi<ForgetPasswordResponse>(
      ApiEndpoints.forgetpassword1,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => ForgetPasswordResponse.fromJson(json),
    );

    return response;
  }

  //-----------FORGET PASSWORD SECOND STEP

  Future<ApiResponse<ForgetPasswordResponse>> secondStep(requesBody) async {
    final response = await ApiClient().postApi<ForgetPasswordResponse>(
      ApiEndpoints.forgetpassword2,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => ForgetPasswordResponse.fromJson(json),
    );

    return response;
  }
}
