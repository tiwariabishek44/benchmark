//---login controlller

import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/first_Login_response.dart';
import 'package:benchmark/app/model/api_response/login_api_response.dart';
import 'package:benchmark/app/model/api_response/teacher_login_response.dart';
import 'package:benchmark/app/model/api_response/user_data_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/modules/common/homepage.dart/homepage.dart';
import 'package:benchmark/app/modules/student_view/student_main_screen/user_main_screen.dart';
import 'package:benchmark/app/repository/ger_user_data_repository.dart';
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

//-------- FOR FROGET PASSWORD-------
  var isPasswordVisible = false.obs;

  void loginUser(BuildContext context) {
    if (loginFromkey.currentState!.validate()) {
      loginOptionControllre.isUser.value ? firstLogin() : teacherLogin();
    }
  }

  final LoginRepository loginRepository = LoginRepository();

  final Rx<ApiResponse<FirstLoginResponse>> firstLoginResponse =
      ApiResponse<FirstLoginResponse>.initial().obs;

  Future<void> firstLogin() async {
    try {
      isLoginLoading(true);
      firstLoginResponse.value = ApiResponse<FirstLoginResponse>.loading();
      final user = {
        "email": emailcontroller.value.text.trim(),
        "password": passwordcontroller.value.text.trim(),
      };
      final loginResult = await loginRepository.firstLogin(user);
      // log(registerResult.status.toString());

      if (loginResult.status == ApiStatus.SUCCESS) {
        log(" this is the login true successful ");
        await login();

        isLoginLoading(false);
      } else {
        isLoginLoading.value = false;
        CustomSnackBar.showFailure(" ${loginResult.message}");
      }
    } catch (e) {
      isLoginLoading(false);
    }
  }

//--------------------SECOND LOGIN / VERIFY FOR THE SINGEL LOGIN ---------------

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

        saveDataLocally(
            loginResult.response?.data!.accessToken.toString(),
            loginResult.response?.data!.refreshToken.toString(),
            loginResult.response?.data!.loginSessionHash.toString(),
            true);

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

//--------------------TEACHER LOGIN ---------------

  final Rx<ApiResponse<TeacherLoginResponse>> teacherLoginResponse =
      ApiResponse<TeacherLoginResponse>.initial().obs;

  Future<void> teacherLogin() async {
    try {
      isLoginLoading(true);
      teacherLoginResponse.value = ApiResponse<TeacherLoginResponse>.loading();
      final user = {
        "email": emailcontroller.value.text.trim(),
        "password": passwordcontroller.value.text.trim(),
      };
      final teacherLoginResult = await loginRepository.teacherLogin(user);
      // log(registerResult.status.toString());

      if (teacherLoginResult.status == ApiStatus.SUCCESS) {
        teacherLoginResponse.value =
            ApiResponse<TeacherLoginResponse>.completed(
                teacherLoginResult.response);

        saveDataLocally(
          teacherLoginResult.response?.data!.accessToken.toString(),
          teacherLoginResult.response?.data!.refreshToken.toString(),
          teacherLoginResult.response?.data!.loginSessionHash.toString(),
          teacherLoginResult.response?.data!.verified,
        );

        isLoginLoading(false);
      } else {
        isLoginLoading.value = false;
        CustomSnackBar.showFailure(" ${teacherLoginResult.message}");
      }
    } catch (e) {
      isLoginLoading(false);

      log("thi is error $e");
    }
  }

//---------TO SAVE USER DATA LOCALLY--------------
  void saveDataLocally(String? accessToken, String? refreshToken,
      String? lgoinsessionhash, bool? isVerified) async {
    await TokenManager.setAccessToken(accessToken);
    await TokenManager.setRefreshToken(refreshToken!);
    await TokenManager.setSessionHash(lgoinsessionhash!);

    storage.write(accoutnType, isVerified!);
    storage.write(
        userType, loginOptionControllre.isUser.value ? 'STUDENT' : 'TEACHER');
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

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    emailcontroller.dispose();
    passwordcontroller.dispose();

    super.onClose();
  }
}
