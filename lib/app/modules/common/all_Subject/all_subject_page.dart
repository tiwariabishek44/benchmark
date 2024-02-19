import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/common/all_Subject/course_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/subject_controller.dart';
import 'package:benchmark/app/modules/student_view/note_list/note_list.dart';
import 'package:benchmark/app/modules/teacher_view/teacher_not_list/teacher_notes_list.dart';
import 'package:benchmark/app/widgets/batch_lable.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllSubjectPage extends StatelessWidget {
  final String title;
  final List<Subject> subject;
  AllSubjectPage({Key? key, required this.title, required this.subject});
  final storage = GetStorage();
  final courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(title: "Grade " + title),
        body: Column(children: [
          SizedBox(
            height: 4,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: subject.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      courseController.fetchNotes('11 physics');
                      if (storage.read(userType) == 'teacher') {
                        Get.to(
                            () => TeacherNotesList(
                                  imagePath: subject[index].image,
                                ),
                            transition: Transition.rightToLeft,
                            duration: duration);
                      } else {
                        Get.to(
                            () => NotesList(
                                  imagePath: subject[index].image,
                                ),
                            transition: Transition.rightToLeft,
                            duration: duration);
                      }
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: greyColor,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage(subject[index].image)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Grade" + subject[index].name,
                                    textAlign: TextAlign
                                        .center, // Centers text within the container
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                }),
          ))
        ]));
  }
}
