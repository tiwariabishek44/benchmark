// TO DISPLAY INFORMATION WHEN THE SESSION IS CLEAR

import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/utils/token_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SessionInfoScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.backgroundColor, // Set background to transparent
      body: WillPopScope(
        onWillPop: () async {
          // Show a message using ScaffoldMessenger when the user tries to close the popup
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logout first!'),
              duration: Duration(seconds: 2),
            ),
          );
          // Return false to prevent the user from closing the popup with the back button
          return false;
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Shadow offset
                    ),
                  ],
                  color: Color.fromARGB(255, 240, 237, 237),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Session Expired",
                      style: AppStyles.mainHeading,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'You\'ve been logged in from another device.',
                      style: AppStyles.listTileTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () {
                        TokenManager.deleteTokens();

                        loginController.logout();
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.8.h),
                          child: Center(
                            child: Text(
                              'Logout',
                              style: AppStyles.listTileTitle1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
