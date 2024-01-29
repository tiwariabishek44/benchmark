import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/profile/profile.dart';
import 'package:benchmark/app/modules/student_view/app_setting/about_us.dart';
import 'package:benchmark/app/widgets/custom_text_form.dart';
import 'package:benchmark/app/widgets/customized_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Widget widget;
  final Function()? onTap;

  Buttons({
    required this.text,
    required this.widget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(text),
        trailing: widget,
      ),
    );
  }
}

class AppSettings extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.r),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Buttons(
                  text: 'Profile',
                  widget: const Icon(Icons.chevron_right),
                  onTap: () {
                    Get.to(() => Profile(), transition: Transition.leftToRight);
                    // Handle onTap action for Profile
                  },
                ),
                Buttons(
                  text: 'Change Password',
                  widget: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle onTap action for Change Password
                  },
                ),
                Buttons(
                  text: 'About Us',
                  widget: const Icon(Icons.chevron_right),
                  onTap: () {
                    Get.to(() => AboutUsPage(),
                        transition: Transition.leftToRight);
                    // Handle onTap action for Feedback
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            child: CustomButton(
              isloaidng: false,
              text: 'LogOut',
              onPressed: () async {
                loginController.logout();
                // Handle confirmation logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
