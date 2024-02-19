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
              style: TextStyle(color: mainColor),
              validator: logincontroller.passwordValidator,
              controller: logincontroller.passwordcontroller,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                prefixIcon: Icon(Icons.lock_outline, color: mainColor),
                labelText: 'Password',
                labelStyle: TextStyle(color: mainColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: mainColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: mainColor, width: 1),
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
                    color: mainColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: const Text("Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 89, 63),
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            Obx(() => CustomButton(
                  isLoading: logincontroller.isLoginLoading.value,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    logincontroller.loginUser(context);
                  },
                  text: "Login",
                )),
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
                        color: mainColor,
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
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 59, 89, 63)),
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
                      fontSize: 20,
                      color: Color.fromARGB(255, 55, 116, 92),
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
