import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  RxBool isUser = true.obs; // Initialize with the default value
}

class LoginOptionView extends StatelessWidget {
  final loginOptionController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                            activeColor: Colors.blue, // Set the selected color
                          ),
                          Text('As Student'),
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
                            activeColor: Colors.blue, // Set the selected color
                          ),
                          Text('As Teacher'),
                        ]),
                      ),
                    )
                  ],
                )),
            LoginScreen()
          ],
        ),
      ),
    );
  }
}
