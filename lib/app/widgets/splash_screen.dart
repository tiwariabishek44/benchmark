// SPLASH SCREEN

import 'dart:async';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/homepage.dart/homepage.dart';
import 'package:benchmark/app/modules/student_view/student_main_screen/user_main_screen.dart';
import 'package:benchmark/app/widgets/account_verificaiton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();
  final loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    // loginController.logout();

    navigateBasedOnAuthState();
  }

  void navigateBasedOnAuthState() {
    Timer(const Duration(seconds: 3), () {
      if (loginController.isLogedIn()) {
        // User is authenticated, navigate to UserMainScreen
        if (storage.read(userType) == 'TEACHER') {
          storage.read(accoutnType)
              ? Get.offAll(() => TeacherHomePage())
              : Get.off(() => VerificationPage());
        } else {
          Get.offAll(() => StudentMainScreenView());
        }
      } else {
        // User is not authenticated, navigate to LoginScreen
        Get.offAll(() => TeacherHomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SpinKitFadingCircle(
              color: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}
