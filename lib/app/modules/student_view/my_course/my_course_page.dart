import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/all_Subject/course_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/subject_controller.dart';
import 'package:benchmark/app/modules/teacher_view/teacher_not_list/teacher_notes_list.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyCoursePage extends StatelessWidget {
  MyCoursePage({super.key});
  final courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: SingleChildScrollView(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: 1,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            courseController.fetchNotes('11 physics');

                            Get.to(
                                () => TeacherNotesList(
                                      imagePath: "assets/images.jpeg",
                                    ),
                                duration: duration,
                                transition: Transition.rightToLeft);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: greyColor,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  allStreams[index].image)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allStreams[index].name,
                                          textAlign: TextAlign
                                              .center, // Centers text within the container
                                          style: TextStyle(
                                            color: mainColor,
                                            fontFamily: FontStyles.poppins,
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
                      })),
            )
          ],
        ),
      ),
    );
  }
}
