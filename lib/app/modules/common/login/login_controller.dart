import 'dart:developer';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/login_api_response.dart';
import 'package:benchmark/app/model/api_response/teacher_login_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/repository/login_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/utils/token_util.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:benchmark/app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends GetxController {
  final loginOptionControllre = Get.put(LoginOptionController());
  final storage = GetStorage();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  var isLoginLoading = false.obs;
  final loginFromkey = GlobalKey<FormState>();
  final termsAndConditions = false.obs;

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }

  var isPasswordVisible = false.obs;

  void loginUser(BuildContext context) {
    if (loginFromkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      login();
    }
  }

  final LoginRepository loginRepository = LoginRepository();

//--------------------  STUDENT LOGIN

  final Rx<ApiResponse<LoginApiResponse>> loginApiResponse =
      ApiResponse<LoginApiResponse>.initial().obs;

  Future<void> login() async {
    try {
      isLoginLoading(true);
      loginApiResponse.value = ApiResponse<LoginApiResponse>.loading();
      final user = {
        "email": emailcontroller.value.text.trim(),
        "password": passwordcontroller.value.text.trim(),
      };
      final loginResult = await loginRepository.loginUser(user);
      // log(registerResult.status.toString());

      if (loginResult.status == ApiStatus.SUCCESS) {
        loginApiResponse.value =
            ApiResponse<LoginApiResponse>.completed(loginResult.response);

        log(" this is he  token ::::::: ${loginResult.response?.data.student.toString()}");

        saveDataLocally(
            loginResult.response?.data.accessToken.toString(),
            loginResult.response?.data.refreshToken.toString(),
            loginResult.response?.data.loginSessionHash.toString(),
            loginResult.response?.data.verified,
            loginResult.response?.data.student);

        isLoginLoading(false);
      } else {
        isLoginLoading.value = false;
        CustomSnackBar.showFailure(" ${loginResult.message}");
      }
    } catch (e) {
      isLoginLoading(false);

      log("thi is error $e");
    }
  }

// //---------TO SAVE USER DATA LOCALLY--------------
  void saveDataLocally(String? accessToken, String? refreshToken,
      String? lgoinsessionhash, bool? isVerified, bool? isStudetn) async {
    await TokenManager.setAccessToken(accessToken);
    await TokenManager.setRefreshToken(refreshToken!);
    await TokenManager.setSessionHash(lgoinsessionhash!);

    storage.write(accoutnType, isVerified!);
    storage.write(userType, isStudetn! ? 'STUDENT' : 'TEACHER');
    // getUserData();
    Get.offAll(() => SplashScreen());
  }

//---------------USER LOGOUT------------
  void logout() async {
    await TokenManager.deleteTokens();
    await storage.remove('userName');
    await storage.remove('email');
    storage.remove(userType);
    await storage.remove(accoutnType);
    Get.offAll(SplashScreen());
  }

//------------TO CHECK IS USER IS LOG IN OR NOT------------
  bool isLogedIn() {
    if (storage.read(userType) != null) {
      log("this is the account type :::::::${storage.read(accoutnType)}");
      //  Map<String, dynamic> decodedToken =
      String token = TokenManager.getAccessToken()!;

      // Decode JWT token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      final email = decodedToken['sub'];
      storage.write('email', email);
      List<String> parts = email.split('@');
      storage.write('userName', parts[0]);

      return true;
    } else {
      return false;
    }
  }

//-------------VALIDATOR-----------------

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
    return null;
  }

  String? vendorVlidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Canteen Code';
    }

    // Return null if the entered email is valid
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for additional criteria (e.g., at least one digit and one special character)

    return null; // Return null if the password meets the criteria
  }
}
