import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/modules/common/register/register_controller.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
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
                        validator: registercontroller.usernameValidator,
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
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Select Stream',
                            style: TextStyle(color: mainColor, fontSize: 15),
                          ),
                        ),
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 3),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: mainColor),
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                iconSize: 36.0,
                                iconEnabledColor: mainColor,
                                elevation: 8,
                                style: TextStyle(color: mainColor),
                                underline: SizedBox(),
                                value: registercontroller.selectedValue.value,
                                items: ['Science', 'Management']
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (newValue) {
                                  registercontroller
                                      .updateSelectedValue(newValue!);
                                },
                              ),
                            ),
                          )),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              style: TextStyle(color: mainColor),
                              validator: registercontroller.passwordValidator,
                              controller: registercontroller.passwordcontroller,
                              obscureText: registercontroller.isPasswordVisible
                                  .value, // Toggle the visibility
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: mainColor,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: mainColor),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: mainColor, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: mainColor, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    registercontroller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: mainColor,
                                  ),
                                  onPressed: () {
                                    registercontroller.isPasswordVisible.value =
                                        !registercontroller
                                            .isPasswordVisible.value;
                                  },
                                ),
                              ),
                            ),
                          )),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              style: TextStyle(color: mainColor),
                              validator:
                                  registercontroller.confirmPasswordValidator,
                              controller:
                                  registercontroller.confirmPasswordController,
                              obscureText: registercontroller
                                  .cornfirmPasswordVisible
                                  .value, // Toggle the visibility
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                prefixIcon:
                                    Icon(Icons.lock_outline, color: mainColor),
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: mainColor),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: mainColor, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: mainColor, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color.fromARGB(255, 255, 255, 255),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      registercontroller
                                              .cornfirmPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: mainColor),
                                  onPressed: () {
                                    registercontroller
                                            .cornfirmPasswordVisible.value =
                                        !registercontroller
                                            .cornfirmPasswordVisible.value;
                                  },
                                ),
                              ),
                            ),
                          )),
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
                      CustomButton(
                        onPressed: () {
                          registercontroller.registerUser(context);
                        },
                        text: 'Register',
                        isLoading: registercontroller.isregisterLoading.value,
                      ),
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
