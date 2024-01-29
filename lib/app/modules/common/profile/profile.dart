import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/profile/profile_controller.dart';
import 'package:benchmark/app/modules/common/profile/profile_info.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'profile_edit.dart';

class Profile extends StatelessWidget {
  final userDataController = Get.put(LoginController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Obx(
          () {
            if (userDataController.isloading.value) {
              return const Center(
                  child: CircularProgressIndicator(color: primaryColor));
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ProfileInfo(
                      'Hari Bahadur',
                      const Icon(Icons.person_2_outlined,
                          color: textIconColor)),
                  ProfileInfo('99********',
                      const Icon(Icons.phone_outlined, color: textIconColor)),
                  ProfileInfo('tiwa******.com',
                      const Icon(Icons.email_outlined, color: textIconColor)),
                  CustomButton(
                      isloaidng: false,
                      onPressed: () {
                        // Get.to(() => ProfileEdit(),
                        //     transition: Transition.leftToRight);
                      },
                      text: 'Update Profile'),
                ],
              );
            }
          },
        ));
  }
}
