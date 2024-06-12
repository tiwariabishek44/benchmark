//LANDING PAGE OF THE APP  - TO DISPLAY HE GRADE

import 'dart:developer';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/common/course/course_controller.dart';
import 'package:benchmark/app/modules/common/physical_items/physical_item_list_view.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/note_list/note_controller.dart';
import 'package:benchmark/app/modules/common/profile/profile_page.dart';

import 'package:benchmark/app/widgets/switch_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TeacherHomePage extends StatelessWidget {
  TeacherHomePage({super.key});
  final loginController = Get.put(LoginController());
  final storage = GetStorage();
  final noteContorller = Get.put(NoteController());
  final courseController = Get.put(CourseController());
  String baseUrl = dotenv.get('BASE_URL');

  bool isPurchased = false; // Initialize with the default value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30.h,
              color: AppColors.mainColor,
              child: Padding(
                padding: AppPadding.screenHorizontalPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(
                                      "Hi, ${loginController.isLogedIn() ? storage.read('userName') : 'Guest ,'}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "Let's Start Learning",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // log("thi sis the string  $baseUrl");
                                  Get.to(() => PhysicalItemView(),
                                      transition: Transition.rightToLeft,
                                      duration: duration);
                                },
                                child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgroundColor,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: AppColors.mainColor,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.offAll(SessionInfoScreen());
                                  Get.to(() => ProfilePage(),
                                      transition: Transition.rightToLeft,
                                      duration: duration);
                                },
                                child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgroundColor,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.settings,
                                        color: AppColors.mainColor,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(
                        () => Container(
                          height: 5.7.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 228, 234, 228),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    noteContorller.selectedTopic.value = 0;
                                  },
                                  child: selectedTopics(
                                      'Streams',
                                      noteContorller.selectedTopic.value == 0
                                          ? AppColors.backgroundColor
                                          : Colors.transparent,
                                      noteContorller.selectedTopic.value == 0
                                          ? AppColors.mainColor
                                          : AppColors.iconColors)),
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    noteContorller.selectedTopic.value = 1;
                                  },
                                  child: selectedTopics(
                                      "Mcq's",
                                      noteContorller.selectedTopic.value == 1
                                          ? AppColors.backgroundColor
                                          : Colors.transparent,
                                      noteContorller.selectedTopic.value == 1
                                          ? AppColors.mainColor
                                          : AppColors.iconColors)),
                            ),
                            storage.read(userType) == 'TEACHER'
                                ? Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          courseController.fetchAllCourse();
                                          noteContorller.selectedTopic.value =
                                              2;
                                        },
                                        child: selectedTopics(
                                            "Mannual",
                                            noteContorller
                                                        .selectedTopic.value ==
                                                    2
                                                ? AppColors.backgroundColor
                                                : Colors.transparent,
                                            noteContorller
                                                        .selectedTopic.value ==
                                                    2
                                                ? AppColors.mainColor
                                                : AppColors.iconColors)),
                                  )
                                : SizedBox.shrink(),
                          ]),
                        ),
                      )
                    ]),
              ),
            ),

            // Second Expanded Container (Flex 7)
            Obx(() => Container(
                  height: 70.h,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: AppPadding.screenHorizontalPadding,
                    child: SwitchCaseWidget(
                      selectedTopic: noteContorller.selectedTopic.value,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget selectedTopics(String label, Color backgroundColor, Color textColor) {
    return Container(
        height: 5.7.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: backgroundColor),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 17.sp,
            ),
          ),
        ));
  }
}
