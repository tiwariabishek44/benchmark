import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/forget_password/forget_password_controller.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/forget_password/new_password_page.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final forgetPasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: forgetPasswordController.forgetPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Forget password",
                  style: AppStyles.mainHeading,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomizedTextfield(
                  validator: forgetPasswordController.emailValidator,
                  icon: Icons.email_outlined,
                  myController: forgetPasswordController.emailoCntroller1,
                  hintText: "Enter Email",
                ),
                SizedBox(height: 2.h),
                Text(
                  "We'll send the verification code to this email if it matches an existing Benchmark account",
                  style: AppStyles.listTilesubTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Obx(() => CustomButton(
                    text: 'Send OTP',
                    onPressed: () {
                      forgetPasswordController.sendOtp(context);
                    },
                    isLoading: forgetPasswordController.sendOtpLoading.value))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
