import 'dart:developer';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/profile/change_password/change_password_controller.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Change Password'),
      body: SingleChildScrollView(
          child: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Form(
          key: changePasswordController.fomkey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 20.w, // Adjust the size of the circle as needed
                backgroundImage: AssetImage(
                    'assets/changePassword.jpeg'), // Replace with your image asset
              ),
              // Obx(() => CustomTextForm(
              //       controller: changePasswordController.oldPasswordController,
              //       labelText: 'Old Password',
              //       hintText: '*************',
              //       iconWidget: const Icon(Icons.lock_open,
              //           size: 22, color: textIconColor),
              //       obscureText: changePasswordController.obscureText2.value,
              //       keyboardType: TextInputType.text,
              //       onChanged: (val) {
              //         // setState(() {});
              //       },
              //       suffixIcon: IconButton(
              //           onPressed: () {
              //             changePasswordController.obscureText2.value =
              //                 !changePasswordController.obscureText2.value;
              //             // setState(() {
              //             //   obscureText2 = !obscureText2;
              //             // });
              //           },
              //           icon: changePasswordController.obscureText2.value
              //               ? Icon(Icons.visibility_off)
              //               : Icon(Icons.visibility)),
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'Please enter old password';
              //         }
              //         return null;
              //       },
              //     )),
              // Obx(() => CustomTextForm(
              //       controller: changePasswordController.newPasswordController,
              //       labelText: 'New Password',
              //       hintText: '*************',
              //       iconWidget: const Icon(Icons.lock_open,
              //           size: 22, color: textIconColor),
              //       obscureText: changePasswordController.obscureText.value,
              //       keyboardType: TextInputType.text,
              //       onChanged: (val) {
              //         // setState(() {});
              //       },
              //       suffixIcon: IconButton(
              //           onPressed: () {
              //             changePasswordController.obscureText.value =
              //                 !changePasswordController.obscureText.value;
              //           },
              //           icon: changePasswordController.obscureText.value
              //               ? Icon(Icons.visibility_off)
              //               : Icon(Icons.visibility)),
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'Please enter new password';
              //         }
              //         return null;
              //       },
              //     )),
              // Obx(() => CustomTextForm(
              //       controller: changePasswordController.cPasswordController,
              //       labelText: 'Confirm Password',
              //       hintText: '*************',
              //       iconWidget: const Icon(Icons.lock_open,
              //           size: 22, color: textIconColor),
              //       obscureText: changePasswordController.obscureText1.value,
              //       keyboardType: TextInputType.text,
              //       onChanged: (val) {},
              //       suffixIcon: IconButton(
              //           onPressed: () {
              //             changePasswordController.obscureText1.value =
              //                 !changePasswordController.obscureText1.value;
              //           },
              //           icon: changePasswordController.obscureText1.value
              //               ? Icon(Icons.visibility_off)
              //               : Icon(Icons.visibility)),
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return 'Please enter Cornfirm Password';
              //         }
              //         return null;
              //       },
              //     )),
              SizedBox(
                height: 5.h,
              ),
              Obx(() => CustomButton(
                    isLoading: changePasswordController.updateLodaing.value,
                    onPressed: () {
                      log("this is the ");
                      FocusScope.of(context).unfocus();
                      changePasswordController.changePasswordSubmit();
                    },
                    text: "Change Password",
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
