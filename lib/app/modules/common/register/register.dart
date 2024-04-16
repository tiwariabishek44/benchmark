import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/modules/common/register/register_controller.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/custom_password_field.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registercontroller = Get.put(RegisterController());
  final loginOptionController = Get.put(LoginOptionController());
  String? _selectedOption;
  final List<String> options = [
    'Science',
    'Management',
  ];
  // Replace with your own options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: backgroundColor,
        ),
        body: Container(
            color: backgroundColor,
            width: MediaQuery.of(context).size.width,
            height: context.height,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Form(
                  key: registercontroller.registerFromkey,
                  child: Column(
                    children: [
                      Obx(() => WelcomeHeading(
                            mainHeading: "Let's Start",
                            subHeading: loginOptionController.isUser.value
                                ? "Regster As Student"
                                : "Register As Teacher",
                          )),
                      SizedBox(height: 10),
                      CustomizedTextfield(
                        validator: registercontroller.emailValidator,
                        icon: Icons.email_outlined,
                        myController: registercontroller.emailcontroller,
                        hintText: "Email",
                      ),
                      CustomizedTextfield(
                        validator: registercontroller.phoneValidator,
                        icon: Icons.phone,
                        myController: registercontroller.phonenocontroller,
                        hintText: "Phone",
                      ),
                      CustomizedTextfield(
                        validator: registercontroller.usernameValidator,
                        icon: Icons.person,
                        myController: registercontroller.namecontroller,
                        hintText: "Name",
                      ),
                      gapH2,
                      Obx(
                        () => CustomPasswordField(
                          onPressed: () {
                            registercontroller.isPasswordVisible.value =
                                !registercontroller.isPasswordVisible.value;
                          },
                          validator: registercontroller.passwordValidator,
                          controller: registercontroller.passwordcontroller,
                          labelText: 'Password',
                          icon: Icons.lock_outline,
                          isVisible: registercontroller.isPasswordVisible
                              .value, // or false based on your requirement
                        ),
                      ),
                      Obx(
                        () => CustomPasswordField(
                          onPressed: () {
                            registercontroller.cornfirmPasswordVisible.value =
                                !registercontroller
                                    .cornfirmPasswordVisible.value;
                          },
                          validator:
                              registercontroller.confirmPasswordValidator,
                          controller:
                              registercontroller.confirmPasswordController,

                          labelText: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isVisible: registercontroller.cornfirmPasswordVisible
                              .value, // or false based on your requirement
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          registercontroller.termsAndConditions.value =
                              !registercontroller.termsAndConditions.value;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                              () => Checkbox(
                                value:
                                    registercontroller.termsAndConditions.value,
                                onChanged: (value) {
                                  registercontroller.termsAndConditions.value =
                                      value!;
                                },
                                activeColor: Color.fromARGB(255, 55, 116, 92),
                                checkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                                splashRadius: 1.5.h,
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 55, 116, 92),
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            Flexible(
                              child: RichText(
                                softWrap: true,
                                maxLines: 2,
                                text: TextSpan(
                                  text: "I have read and accept the ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 59, 89, 63),
                                      fontFamily: FontStyles.poppins),
                                  children: [
                                    TextSpan(
                                      text: "Terms and Privacy Policy",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: TextStyle(
                                        fontSize: 15.5.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 55, 116, 92),
                                        fontFamily: FontStyles.poppins,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() => CustomButton(
                            onPressed: () {
                              registercontroller.registerUser(context);
                            },
                            text: 'Register',
                            isLoading:
                                registercontroller.isregisterLoading.value,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )))
              ]),
            ))));
  }
}
