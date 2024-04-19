// TO SAVE THE TOKENS LOCALLY

import 'dart:developer';

import 'package:benchmark/app/config/prefs.dart';
import 'package:get_storage/get_storage.dart';

class TokenManager {
  static final box = GetStorage();

  static Future<void> setAccessToken(String? accessToken) async {
    await box.write(accessTokenKey, accessToken);
  }

  static String? getAccessToken() {
    return box.read(accessTokenKey);
  }

  static Future<void> setSessionHash(String sessionHash) async {
    await box.write(sessionHashKey, sessionHash);
    log(" we are try to set the session hass in toen utility .dart  ${sessionHash}");
  }

  static String? getSessionHash() {
    return box.read(sessionHashKey);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    await box.write(refreshTokenKey, refreshToken);
  }

  static String? getRefreshToken() {
    return box.read(refreshTokenKey);
  }

  static Future<void> deleteTokens() async {
    await box.remove(accessTokenKey);
    await box.remove(sessionHashKey);
    await box.remove(refreshTokenKey);
  }
}
