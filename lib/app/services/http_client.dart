//  TO REFRESH THE ACCESS TOKEN

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:benchmark/app/model/api_response/forbidden_access_response.dart';
import 'package:benchmark/app/model/api_response/refresh_access_token.dart';
import 'package:benchmark/app/utils/token_util.dart';
import 'package:benchmark/app/widgets/session_pop_up.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String BASE_URL = dotenv.get('BASE_URL');
const String ACCESS_TOKEN_REFRESH_ENDPOINT =
    "/api/open/common/account/access-token/refresh";
const String FORBIDDEN_ACCESS = "FORBIDDEN_ACCESS";
const String INVALID_SESSION = "INVALID_SESSION";
const int DUPLICATE_STUDENT_LOGIN_SESSION = 450;

class TokenInterceptor extends http.BaseClient {
  final http.Client _inner = http.Client();

  TokenInterceptor() {}

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

    // Read the entire response into memory
    var responseBytes = await response.stream.toBytes();

    var responseBody = utf8.decode(responseBytes);

    //handle duplicate student login session
    if (response.statusCode == DUPLICATE_STUDENT_LOGIN_SESSION) {
      Get.offAll(SessionInfoScreen());
    }

    // Handle different status codes
    if (response.statusCode == 401) {
      await refreshAccessToken();
      request.headers['Authorization'] =
          'Bearer ' + TokenManager.getAccessToken()!;
      return _inner.send(request);
    } else if (response.statusCode == 403) {
      var jsonData = jsonDecode(responseBody);
      ForbiddenAccessResponse forbiddenAccessResponse =
          ForbiddenAccessResponse.fromJson(jsonData);
      if (forbiddenAccessResponse.message == FORBIDDEN_ACCESS) {
        // handle forbidden access
      } else if (forbiddenAccessResponse.message == INVALID_SESSION) {
        TokenManager.deleteTokens();
        log(" this is the forbidden ");
        // handle invalid user session here.
      }
    }

    return http.StreamedResponse(
      Stream.fromIterable(
          [responseBody.codeUnits]), // Return the response body as stream
      response.statusCode,
      contentLength: responseBody.length,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
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

final TokenInterceptor httpClient = TokenInterceptor();



