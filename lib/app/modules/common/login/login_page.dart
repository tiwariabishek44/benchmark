import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/register/register.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/homepage.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logincontroller = Get.put(LoginController());

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: logincontroller.loginFromkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            CustomizedTextfield(
              validator: logincontroller.emailValidator,
              icon: Icons.email_outlined,
              myController: logincontroller.emailcontroller,
              hintText: "Email",
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: logincontroller.passwordValidator,
              controller: logincontroller.passwordcontroller,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Password',
                labelStyle: TextStyle(color: secondaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    color: secondaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                logincontroller.termsAndConditions.value =
                    !logincontroller.termsAndConditions.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Checkbox(
                      value: logincontroller.termsAndConditions.value,
                      onChanged: (value) {
                        logincontroller.termsAndConditions.value = value!;
                      },
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                      splashRadius: 1.5.h,
                      side: const BorderSide(
                        color: primaryColor,
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
                            color: Colors.black,
                            fontFamily: FontStyles.poppins),
                        children: [
                          TextSpan(
                            text: "Terms and Privacy Policy",
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: TextStyle(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: const Text("Forgot Password?",
                      style: TextStyle(
                        color: Color(0xff6A707C),
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            CustomButton(
              isloaidng: false,
              onPressed: () {
                FocusScope.of(context).unfocus();
                logincontroller.signin();
              },
              text: "Login",
            ),
            SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 97, 96, 96),
                      height: 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color.fromARGB(255, 97, 96, 96),
                      height: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RegisterPage());
                    // Handle navigation to registration page
                    // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => YourRegistrationPage()));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 243, 124, 33),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
