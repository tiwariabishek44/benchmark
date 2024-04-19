// TO REFRESH THE ACCESS TOKEN FOR THE  PAID PDF ACCESS

import 'dart:async';
import 'dart:convert';
import 'package:benchmark/app/model/api_response/refresh_access_token.dart';
import 'package:benchmark/app/utils/token_util.dart';
import 'package:benchmark/app/widgets/session_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final String BASE_URL = "http://localhost:8080";
final String ACCESS_TOKEN_REFRESH_ENDPOINT =
    "/api/open/common/account/access-token/refresh";
final String FORBIDDEN_ACCESS = "FORBIDDEN_ACCESS";
final String INVALID_SESSION = "INVALID_SESSION";
const int DUPLICATE_STUDENT_LOGIN_SESSION = 450;

class TokenInterceptor1 extends http.BaseClient {
  final http.Client _inner = http.Client();

  TokenInterceptor1();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (TokenManager.getAccessToken() != null) {
      request.headers['Authorization'] =
          'Bearer ' + TokenManager.getAccessToken()!;
    }

    if (TokenManager.getSessionHash() != null) {
      request.headers['SessionHash'] = TokenManager.getSessionHash()!;
    }

    final response = await _inner.send(request);

    //handle duplicate student login session
    if (response.statusCode == DUPLICATE_STUDENT_LOGIN_SESSION) {
      Get.offAll(SessionInfoScreen());
    }

    // Handle different status codes
    if (response.statusCode == 401) {
      await refreshAccessToken();
      if (TokenManager.getAccessToken() != null) {
        request.headers['Authorization'] =
            'Bearer ' + TokenManager.getAccessToken()!;
      }
      return _inner.send(request);
    } else if (response.statusCode == 403) {
      final stream = Stream.value(utf8.encode('')); // Empty response body
      return http.StreamedResponse(
        stream,
        response.statusCode,
        contentLength: 0,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    }

    return response;
  }

  Future<void> refreshAccessToken() async {
    if (TokenManager.getRefreshToken() == null) {
      TokenManager.deleteTokens();
      // handle empty refreshToken condition here.
    }
    // Define the endpoint URL
    var url = Uri.parse('$BASE_URL$ACCESS_TOKEN_REFRESH_ENDPOINT');

    // Define the request body (if any)
    var requestBody = {
      // Add any parameters needed for the POST request
      'refreshToken': TokenManager.getRefreshToken(),
    };

    try {
      // Make the POST request
      var response = await http.post(
        url,
        body: requestBody,
      );
      if (response.statusCode == 200) {
        RefreshAccessTokenResponse accessTokenResponse =
            RefreshAccessTokenResponse.fromJson(jsonDecode(response.body));
        TokenManager.setAccessToken(accessTokenResponse.data?.accessToken);
      } else if (response.statusCode == 400) {
        TokenManager.deleteTokens();
        //handle corrupted refreshToken
      } else {}
    } catch (error) {
      // handle error
    }
  }
}

final TokenInterceptor1 pdfHttpClient = TokenInterceptor1();
