// PROFILE PAGE

import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/common/profile/about_us.dart';
import 'package:benchmark/app/modules/common/profile/terms_and_conditions.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/pop_up_logout.dart';
import 'package:benchmark/app/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final loginController = Get.put(LoginController());
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Settings'),
      body: SingleChildScrollView(
          child: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: loginController.isLogedIn()
            ? Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Center(
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/person.png',
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  storage.read('userName'),
                  style: AppStyles.mainHeading,
                ),
                Text(
                  storage.read('email'),
                  style: AppStyles.subtitleStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => AboutUs(),
                        transition: Transition.rightToLeft, duration: duration);
                  },
                  title: "About Us",
                  leadingIcon: const Icon(Icons.info_outline),
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => TermsAndConditionsPage(),
                        transition: Transition.rightToLeft, duration: duration);
                  },
                  title: "Terms & Conditions",
                  leadingIcon: const Icon(Icons.policy_outlined),
                ),
                ProfileTile(
                  onTap: () {
                    showLogoutPopup(context);
                  },
                  title: "Logout",
                  leadingIcon: const Icon(
                    Icons.logout,
                  ),
                )
              ])
            :
            //-----------------when the user is not login-------------
            Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Center(
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/person.png',
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Guest ",
                  style: AppStyles.mainHeading,
                ),
                Text(
                  "guest*****@gmail.com",
                  style: AppStyles.subtitleStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => AboutUs(),
                        transition: Transition.rightToLeft, duration: duration);
                  },
                  title: "About Us",
                  leadingIcon: const Icon(Icons.info_outline),
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => TermsAndConditionsPage(),
                        transition: Transition.rightToLeft, duration: duration);
                  },
                  title: "Terms & Conditions",
                  leadingIcon: const Icon(Icons.policy_outlined),
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(
                      () => LoginOptionView(),
                    );
                  },
                  title: "Login",
                  leadingIcon: const Icon(
                    Icons.login,
                  ),
                )
              ]),
      )),
    );
  }
}
