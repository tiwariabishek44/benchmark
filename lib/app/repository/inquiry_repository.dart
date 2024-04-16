import 'dart:developer';
import 'dart:io';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/course_buy_response.dart';
import 'package:benchmark/app/model/api_response/inquiry_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class InquiryRepository {
  Future<ApiResponse<InquryResponse>> inquiry(requesBody) async {
    final response = await ApiClient().postApi<InquryResponse>(
      ApiEndpoints.inquiryApi,
      requestBody: requesBody,
      isTokenRequired: true,
      responseType: (json) => InquryResponse.fromJson(json),
    );

    return response;
  }
}
