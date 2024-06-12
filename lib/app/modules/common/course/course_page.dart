//TO DISPLAY THE COURSE OF RESPECTVE GRADE

import 'dart:developer';

import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/course/course_controller.dart';
import 'package:benchmark/app/modules/common/note_list/note_controller.dart';
import 'package:benchmark/app/modules/common/note_list/note_list.dart';

import 'package:get_storage/get_storage.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class CoursePage extends StatelessWidget {
  final String title;

  CoursePage({Key? key, required this.title});

  final courseController = Get.put(CourseController());
  final noteController = Get.put(NoteController());
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Grade $title'),
      ),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Obx(() {
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
              final filteredCourses = courseController
                  .courseResponse.value.response!.data
                  .where((course) {
                final titleParts = title.split(' ');
                final grades = titleParts[0].toLowerCase();
                final stream = titleParts[1].toLowerCase();

                log(" ::::::::::::::: ths is grade ${stream} and the course stream is ${course.stream}");
                return course.grade == grades &&
                    (course.stream.toLowerCase() == stream.toLowerCase() ||
                        course.stream.toLowerCase() == "both");
              }).toList();

              if (filteredCourses.isEmpty) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                  child: Text(
                    'No Courses are Available',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: filteredCourses.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext ctx, index) {
                  final course = filteredCourses[index];

                  return InkWell(
                    onTap: () {
                      noteController.fetchAllNotes(
                        course.stream,
                        title.split(' ')[0],
                        course.subject!,
                      );

                      Get.to(
                        () => NotesList(
                          data: course,
                          imagePath: 'assets/courseLogo.jpg',
                        ),
                        transition: Transition.rightToLeft,
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
                                      image:
                                          AssetImage('assets/courseLogo.jpg')),
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
                                storage.read(userType) == 'TEACHER'
                                    ? Container()
                                    : Text(
                                        "Price: Rs ${course.price}",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.iconColors,
                                          fontFamily: FontStyles.poppins,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                course.stream == "BOTH"
                                    ? Container(
                                        height: 1.h,
                                        width: 1.h,
                                        color: AppColors.iconColors,
                                      )
                                    : Container()
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
        }),
      ),
    );
  }
}
