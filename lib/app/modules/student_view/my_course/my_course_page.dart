import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/all_Subject/course_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/note_controller.dart';
import 'package:benchmark/app/modules/common/note_list/note_list.dart';
import 'package:benchmark/app/modules/student_view/my_course/my_course_controller.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyCoursePage extends StatelessWidget {
  MyCoursePage({super.key});
  final mycourseController = Get.put(MyCourseController());
  final noteContorller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    mycourseController.getPurchaseCourse();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'benchmark'),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "My Course",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: mainColor),
                )),
            SizedBox(
              height: 3.h,
            ),
            Expanded(child: Obx(
              () {
                if (mycourseController.isLoading.value) {
                  return LoadingScreen();
                } else {
                  if (mycourseController.courseLoaded.value) {
                    return SingleChildScrollView(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: mycourseController
                                .myCourseResponse.value.response!.data.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  noteContorller.fetchAllNotes(
                                      mycourseController.myCourseResponse.value
                                          .response!.data[index].stream,
                                      mycourseController.myCourseResponse.value
                                          .response!.data[index].grade,
                                      mycourseController.myCourseResponse.value
                                          .response!.data[index].subject);
                                  Get.to(
                                    () => NotesList(
                                      isPurchaseCourse: true,
                                      data: mycourseController.myCourseResponse
                                          .value.response!.data[index],
                                      imagePath:
                                          "https://media.wiley.com/product_data/coverImage300/90/11194601/1119460190.jpg",
                                    ),
                                    transition: Transition.rightToLeft,
                                    duration: duration,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 1))
                                      ]),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: greyColor,
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        'assets/courseLogo.jpg')),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mycourseController
                                                    .myCourseResponse
                                                    .value
                                                    .response!
                                                    .data[index]
                                                    .subject,
                                                textAlign: TextAlign
                                                    .center, // Centers text within the container
                                                style: TextStyle(
                                                  color: mainColor,
                                                  fontFamily:
                                                      FontStyles.poppins,
                                                  fontSize: 17
                                                      .sp, // Use screenutil for font sizing
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                              );
                            }));
                  } else {
                    return Text(" you havent purchase any course");
                  }
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
