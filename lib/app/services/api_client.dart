// CENTER API CALL POINT

import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/services/http_client.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient {
  final storage = GetStorage();

//--------------post api call------------//
  Future<ApiResponse<T>> postApi<T>(
    String endPoint, {
    Map<String, dynamic>? requestBody,
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    try {
      log("TRY TO CALL THE POST API ::::::::::${endPoint}");
      final response = await httpClient.post(Uri.parse(endPoint),
          headers: {
            'Content-Type':
                'application/json', // Adjust content type if necessary
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        final data = responseType != null ? responseType(json) : json as T;

        return ApiResponse.completed(data);
      } else if (response.statusCode == 500) {
        log("error ${response.statusCode}");
        var message = "";

        var responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('error')) {
          message = responseBody['error'];
        } else {
          // If 'message' field is not present, handle other potential error structures
          for (var key in responseBody.keys) {
            if (response.statusCode == 400 || response.statusCode == 404) {
              message = responseBody[key];
            } else {
              for (var key1 in responseBody[key].keys) {
                // Concatenate the error message values with comma separation
                message += responseBody[key][key1][0] + ", ";
              }
            }
          }
        }

        return ApiResponse.error(message);
      } else {
        log("error ${response.statusCode}");
        var message = "";

        var responseBody = jsonDecode(response.body);
 
        if (responseBody.containsKey('message')) {
          message = responseBody['message'];
        } else {
          // If 'message' field is not present, handle other potential error structures
          for (var key in responseBody.keys) {
            if (response.statusCode == 400 || response.statusCode == 404) {
              message = responseBody[key];
            } else {
              for (var key1 in responseBody[key].keys) {
                // Concatenate the error message values with comma separation
                message += responseBody[key][key1][0] + ", ";
              }
            }
          }
        }

 
        return ApiResponse.error(message);


      }
    } on SocketException {
      return ApiResponse.error("Server Error");
    } catch (e) {
   
   
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }

// ---------------get api call-------------//

  Future<ApiResponse<T>> getApi<T>(
    String endPoint, {
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    try {
      // log("-----INSIDE THE API CLIENT  ${TokenManager.getAccessToken()} ");
 
      log("THIS IS THE URL :::::: ${endPoint}");
      final response = await httpClient.get(Uri.parse(endPoint));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        final data = responseType != null ? responseType(json) : json as T;

        return ApiResponse.completed(data);
      } else {
        log("error ${response.statusCode}");
        var message = "";

        var responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('message')) {
          message = responseBody['message'];
        } else {
          // If 'message' field is not present, handle other potential error structures
          for (var key in responseBody.keys) {
            if (response.statusCode == 400 || response.statusCode == 404) {
              message = responseBody[key];
            } else {
              for (var key1 in responseBody[key].keys) {
                // Concatenate the error message values with comma separation
                message += responseBody[key][key1][0] + ", ";
              }
            }
          }
        }

// Log and return the error message
        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("Server Error");
    } catch (e) {
      // log(e.toString() + "hello from api_clien");
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }
 
}

class ApiResponse<T> {
  ApiStatus status;
  T? response;
  String? message;

  ApiResponse.initial([this.message])
      : status = ApiStatus.INITIAL,
        response = null;

  ApiResponse.loading([this.message])
      : status = ApiStatus.LOADING,
        response = null;
  ApiResponse.completed(this.response)
      : status = ApiStatus.SUCCESS,
        message = null;
  ApiResponse.error([this.message])
      : status = ApiStatus.ERROR,
        response = null;

  @override
  String toString() {
    return "Status : $status \nData : $response \nMessage : $message";
  }
}

class ApiMessage {
  String getMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid Credentails';
      case 401:
        return 'Unauthorised';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Bad Request';
      case 502:
        return 'Server Error';
      default:
        return 'Error getting data. Error Code: $statusCode';
    }
  }
}

enum ApiStatus { INITIAL, LOADING, SUCCESS, ERROR }
