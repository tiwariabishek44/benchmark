import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:benchmark/app/config/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final storage = GetStorage();

//--------------post api call------------//
  Future<ApiResponse<T>> postApi<T>(
    String endPoint, {
    Map<String, dynamic>? requestBody,
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    Map<String, String> header;

    if (isTokenRequired!) {
      header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${storage.read(accessToken)}"
      };
    } else {
      header = {
        "Content-Type": "application/json",
      };
    }

    try {
      log("-----INSIDE THE API CLIEN");
      var apiUrl = Uri.parse(endPoint);
      log("API CALL URL${apiUrl} AND HEADER ${requestBody}");

      var response = await http.post(apiUrl,
          body: jsonEncode(requestBody), headers: header);
      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        final data = responseType != null ? responseType(json) : json as T;

        return ApiResponse.completed(data);
      } else {
        log("error");

        var message = "";
        for (var key in jsonDecode(response.body).keys) {
          log(key);
          log("fdf: ${jsonDecode(response.body)[key]}");
          if (response.statusCode == 400 || response.statusCode == 404) {
            message = jsonDecode(response.body)[key];
          } else {
            for (var key1 in jsonDecode(response.body)[key].keys) {
              log("fdshfkjd: ${jsonDecode(response.body)[key][key1][0]}");
              // concatenate the value with comma separated
              message += jsonDecode(response.body)[key][key1][0] + ", ";
            }
          }
        }

        log(jsonDecode(response.body).keys.toString());

        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }

// ---------------get api call-------------//
//
  Future<ApiResponse<T>> getApi<T>(
    String endPoint, {
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    Map<String, String> header;

    if (isTokenRequired!) {
      header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${storage.read(accessToken)}"
      };
    } else {
      header = {
        "Content-Type": "application/json",
      };
    }

    try {
      // log("-----TRYIN TO GET DATA FROM URL : ${endPoint}");
      log("this is the get api call  ${endPoint}");

      final response = await http.get(Uri.parse(endPoint), headers: header);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        // log("GET REQUEST FROM URL : ${endPoint} IS : ${jsonDecode(response.body).toString()}");
        // log("IT IS THE USER  DATA ${response.statusCode}, ${response.body}");

        final data = responseType != null ? responseType(json) : json as T;

        return ApiResponse.completed(data);
      } else {
        log("error");

        var message = "";
        for (var key in jsonDecode(response.body).keys) {
          log(key);
          log("fdf: ${jsonDecode(response.body)[key]}");
          if (response.statusCode == 400 || response.statusCode == 404) {
            message = jsonDecode(response.body)[key];
          } else {
            for (var key1 in jsonDecode(response.body)[key].keys) {
              log("fdshfkjd: ${jsonDecode(response.body)[key][key1][0]}");
              // concatenate the value with comma separated
              message += jsonDecode(response.body)[key][key1][0] + ", ";
            }
          }
        }

        log(jsonDecode(response.body).keys.toString());

        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }

//-----------------------PUT API CALL-------------------//
  Future<ApiResponse<T>> putApi<T>(
    String endPoint, {
    Map<String, dynamic>? requestBody,
    T Function(dynamic json)? responseType,
  }) async {
    try {
      var header = {
        "Content-Type": "multipart/form-data",
        "Accept": "application/json",
        "Authorization": "Bearer ${storage.read(accessToken)}"
      };
      log(" ------------THS IS HE  PUT api CALL");

      var response = await http.put(
        Uri.parse(endPoint),
        headers: header,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        final data = responseType != null ? responseType(json) : json as T;

        return ApiResponse.completed(data);
      } else {
        final message = ApiMessage().getMessage(response.statusCode);
        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
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
