//---login controlller

import 'dart:developer';

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/model/api_response/login_response_model.dart';
import 'package:benchmark/app/model/api_response/user_data_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/modules/teacher_view/homepage.dart/homepage.dart';
import 'package:benchmark/app/modules/student_view/student_main_screen/user_main_screen.dart';
import 'package:benchmark/app/repository/ger_user_data_repository.dart';
import 'package:benchmark/app/repository/login_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:benchmark/app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final loginOptionControllre = Get.put(LoginOptionController());
  final storage = GetStorage();
  // TextEditingController for the email field
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final vendorCode = TextEditingController();

  var isLoginLoading = false.obs;
  final loginFromkey = GlobalKey<FormState>();
  final termsAndConditions = false.obs;
  final vendorLoginFromkey = GlobalKey<FormState>();

  void loginUser(BuildContext context) {
    if (loginFromkey.currentState!.validate()) {
      log('USER IS LOGIN');
      login(context);
    } else {}
  }

  final LoginRepository loginRepository = LoginRepository();
  final Rx<ApiResponse<LoginResponseModel>> loginResponse =
      ApiResponse<LoginResponseModel>.initial().obs;

  Future<void> login(BuildContext context) async {
    try {
      isLoginLoading(true);
      loginResponse.value = ApiResponse<LoginResponseModel>.loading();
      final user = {
        "email": emailcontroller.value.text.trim(),
        "password": passwordcontroller.value.text.trim(),
      };
      log('-------------------------user data-------------');
      final loginResult = await loginRepository.loginUser(user);
      // log(registerResult.status.toString());

      if (loginResult.status == ApiStatus.SUCCESS) {
        loginResponse.value =
            ApiResponse<LoginResponseModel>.completed(loginResult.response);
        saveDataLocally(loginResult.response?.tokens.toString(),
            loginResult.response?.userData.id.toString());
        CustomSnackBar.showSuccess("Login Success");

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

//-------------GET USER DATA ------------
  final userDataRepository = Get.put(GetUserDataRepository());
  final Rx<ApiResponse<GetUserDataResponse>> userDataResponse =
      ApiResponse<GetUserDataResponse>.initial().obs;

  Future<void> getUserData() async {
    userDataResponse.value = ApiResponse<GetUserDataResponse>.loading();
    final userDataResult = await userDataRepository
        .getuserData(ApiEndpoints.getUserDetails + "/${storage.read(userId)}");
    if (userDataResult.status == ApiStatus.SUCCESS) {
      log(" ----THIS IS THE USER DATA FETCH SUCCESFULL");

      userDataResponse.value =
          ApiResponse<GetUserDataResponse>.completed(userDataResult.response);
    } else {}
  }

//---------TO SAVE USER DATA LOCALLY--------------
  void saveDataLocally(String? accessToken, String? userid) {
    storage.write(accessToken!, accessToken);
    storage.write(userId, userid);
    storage.write(
        userType, loginOptionControllre.isUser.value ? 'student' : 'teacher');
    getUserData();
    Get.offAll(() => loginOptionControllre.isUser.value
        ? UserMainScreenView()
        : TeacherHomePage());
  }

//----------USER AUTO LOGIN-------------
  bool autoLogin() {
    log("AUTO LOGIN");
    if (storage.read(accessToken) != null && storage.read(userType) != null) {
      getUserData();
      // set a periodic timer to refresh token
      return true;
    }
    return false;
  }

//---------------USER LOGOUT------------
  void logout() {
    storage.remove(accessToken);
    storage.remove(userType);
    Get.offAll(SplashScreen());
    log(storage.read(userType).toString());
  }

//------------TO CHECK IS USER IS LOG IN OR NOT------------
  bool isLogedIn() {
    if (storage.read(userType) != null) {
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

// // login
// class LoginController extends GetxController {
//   final TextEditingController mobileNumber = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   var termsAndConditions = false.obs;
//   var isPasswordVisible = false.obs;
//   final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
//   final storage = GetStorage();
// //----focous node for the form validation

//   final mobileNumberFocus = FocusNode();
//   final passwordFocus = FocusNode();

//   // Check validation for the inputs for login
//   void userLogin(BuildContext context) {
//     log("this is ");
//     if (loginFormKey.currentState!.validate()) {
//       dologin(context);
//     }
//   }

//   var isLoginLoading = false.obs;
//   var loginApiResponse = ApiResponse<LoginResponse>.initial().obs;
//   final loginRepo = LoginRepository();
//   void dologin(BuildContext context) async {
//     try {
//       isLoginLoading.value = true;
//       final reqbody = {
//         "mobileNumber": mobileNumber.text,
//         "password": passwordController.text,
//       };
//       final response = await loginRepo.login(reqbody);
//       log("this is login response" + response.status.toString());
//       loginApiResponse.value = response;
//       //==============Observe the API Response ===========
//       if (response.status == ApiStatus.SUCCESS) {
//         log("lOGIN SUCCESSS:::::");
//         isLoginLoading.value = false;
//         Get.offAll(HomeView());
//       } else {
//         isLoginLoading.value = false;
//         CustomSnackbar.showFailure(context, " ${response.message}");
//       }
//     } catch (e) {
//       // CustomSnackbar.showFailure(context, 'Login error${e.toString()}');

//       isLoginLoading(false);
//     }
//   }
// }
