import 'package:benchmark/app/config/constants.dart';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/course/course_controller.dart';
import 'package:benchmark/app/modules/common/manual/mannual_controller.dart';
import 'package:benchmark/app/modules/common/manual/mannual_list.dart';
import 'package:benchmark/app/modules/common/note_list/note_controller.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class MannualSubjectList extends StatelessWidget {
  MannualSubjectList({super.key});

  final courseController = Get.put(CourseController());
  final noteController = Get.put(NoteController());
  final storage = GetStorage();
  final mannualController = Get.put(MannualController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (courseController.isLoading.value) {
        return LoadingScreen();
      } else {
        if (!courseController.loded.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Courses Available',
                  style: TextStyle(fontSize: 18.sp),
                ),
                IconButton(
                  onPressed: () {
                    courseController.fetchAllCourse();
                  },
                  icon: Icon(Icons.refresh),
                  iconSize: 20.sp,
                  color: AppColors.mainColor,
                ),
              ],
            ),
          );
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount:
                courseController.courseResponse.value.response!.data.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.75,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (BuildContext ctx, index) {
              final course =
                  courseController.courseResponse.value.response!.data[index];

              return InkWell(
                onTap: () {
                  mannualController.fetchAllMannuals(course.id.toString());
                  Get.to(
                    () => MannualList(
                      title: course.subject,
                    ),
                    transition: Transition.cupertino,
                    duration: duration,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1.sp,
                        blurRadius: 3.sp,
                        offset: Offset(1.sp, 1.sp),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/courseLogo.jpg')),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.subject,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontFamily: FontStyles.poppins,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    });
  }
}
