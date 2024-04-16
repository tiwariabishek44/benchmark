import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'register_controller.dart';

class OtpVerification extends StatelessWidget {
  final registerController = Get.put(RegisterController());

  final String token; // Token parameter

  OtpVerification({
    Key? key, // Fix super.key to Key? key
    required this.token, // Required token parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          // align the icon to the left with 0 padding
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            semanticLabel: 'Back',
                            color: AppColors.iconColors,
                          ),
                        ),
                        const Text(
                          "Otp Verification",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Image(
                              image: AssetImage('assets/otp.png'),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            // "${"enterTheOtpSentTo".tr} $email",
                            " Enter the Otp sent to ${registerController.phonenocontroller.value.text}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w500,
                              color: lightColor,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Pinput(
                            length: 4,
                            onCompleted: (pin) {
                              registerController.otpPin.value = pin;
                            },
                            onChanged: (String? value) {
                              if (value!.isEmpty || value.length < 4) {
                                // registerController.otpError.value = true;
                              } else {
                                // registerController.otpError.value = false;
                              }
                            },
                          ),
                          // Obx(
                          //   () => registerController.otpError.value
                          //       ? const CustomError(
                          //           text: 'Please enter valid OTP')
                          //       : const SizedBox(),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  registerController.verify(context, token);
                                },
                                text: 'Verify',
                                isLoading: registerController.isOtpVerify.value,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't Receive The Otp?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: lightColor,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   height: 5.h,
                              //   child: Obx(
                              //     () => registerController
                              //             .isverificationSentLoading.value
                              //         ? TextButton(
                              //             onPressed: () {},
                              //             child:
                              //                 const CircularProgressIndicator(
                              //               color: primaryColor,
                              //               strokeWidth: 2,
                              //             ),
                              //           )
                              //         : registerController.canResend.value ==
                              //                 false
                              //             ? SizedBox(
                              //                 width: 12.w,
                              //               )
                              //             : TextButton(
                              //                 onPressed: () {},
                              //                 child: const Text(
                              //                   "Resend Otp",
                              //                   style: TextStyle(
                              //                     fontSize: 12,
                              //                     fontWeight: FontWeight.w500,
                              //                     color: primaryColor,
                              //                   ),
                              //                 ),
                              //               ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => registerController.isregisterLoading.value == true
                ? const LoadingScreen()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}