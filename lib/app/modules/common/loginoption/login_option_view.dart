import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOptionView extends StatelessWidget {
  final loginOptionController = Get.put(LoginOptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Obx(() => WelcomeHeading(
                    mainHeading: 'Welcome to BenchMark',
                    subHeading: loginOptionController.isUser.value
                        ? "Login As Student"
                        : "Login As Teacher",
                  )),
              SizedBox(
                height: 10,
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          !loginOptionController.isUser.value
                              ? loginOptionController.isUser.value =
                                  !loginOptionController.isUser.value
                              : null;
                        },
                        child: Container(
                          child: Row(children: [
                            Radio(
                              value: true,
                              groupValue: loginOptionController.isUser.value,
                              onChanged: (value) {
                                loginOptionController.isUser.value =
                                    !loginOptionController.isUser.value;
                              },
                              activeColor: Color.fromARGB(
                                  255, 55, 116, 92), // Set the selected color
                            ),
                            Text(
                              'As Student',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: loginOptionController.isUser.value
                                      ? mainColor
                                      : null),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          loginOptionController.isUser.value
                              ? loginOptionController.isUser.value =
                                  !loginOptionController.isUser.value
                              : null;
                        },
                        child: Container(
                          child: Row(children: [
                            Radio(
                              value: false,
                              groupValue: loginOptionController.isUser.value,
                              onChanged: (value) {
                                loginOptionController.isUser.value =
                                    !loginOptionController.isUser.value;
                              },
                              activeColor: Color.fromARGB(
                                  255, 55, 116, 92), // Set the selected color
                            ),
                            Text(
                              'As Teacher',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: !loginOptionController.isUser.value
                                      ? mainColor
                                      : null),
                            ),
                          ]),
                        ),
                      )
                    ],
                  )),
              LoginScreen()
            ],
          ),
        ),
      ),
    );
  }
}
