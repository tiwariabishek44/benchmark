import 'dart:developer';

import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/forget_password/forget_password_controller.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewPasswordPage extends StatelessWidget {
  final String email;

  NewPasswordPage({Key? key, required this.email}) : super(key: key);
  final forgetpasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: forgetpasswordController.newPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Enter the 4-digit code",
                  style: AppStyles.mainHeading,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          " Check ",
                          style: AppStyles.listTilesubTitle,
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      "for verification code",
                      style: AppStyles.listTilesubTitle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: Pinput(
                    length: 4,
                    onCompleted: (pin) {
                      forgetpasswordController.otpPin.value = pin;
                      log(" Otp pin ${pin}");
                    },
                    onChanged: (String? value) {
                      if (value!.isEmpty || value.length < 4) {
                        forgetpasswordController.otpError.value = true;
                      } else {
                        forgetpasswordController.otpError.value = false;
                      }
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                CustomizedTextfield(
                  key: const Key("New Password"),
                  validator: forgetpasswordController.passwordValidator,
                  icon: Icons.password,
                  myController: forgetpasswordController.newPasswordController,
                  hintText: "Enter New Password",
                ),
                Text(
                  "If you don't see a code in your innbox, check your spam folder . If it's not there , the email address may not be confirmed, or it may not match an existing Benchmark account.",
                  style: AppStyles.listTilesubTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
                Obx(() => CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                      forgetpasswordController.otpError.value
                          ? log(" Enter the 4 digit otp")
                          : forgetpasswordController.changePassword(context);
                    },
                    isLoading: forgetpasswordController.sendOtpLoading.value))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
