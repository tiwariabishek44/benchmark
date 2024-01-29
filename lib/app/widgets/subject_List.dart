import 'package:benchmark/app/modules/student_view/homepage.dart/homepage_controller.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/note_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SubjectList extends StatelessWidget {
  SubjectList({Key? key});
  final subjectController = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: subjectController.defaultSubjects.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Get.to(
                    () => NotesList(
                          title: subjectController.defaultSubjects[index].name,
                        ),
                    transition: Transition.leftToRight);
              },
              child: Container(
                height: 9.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 134, 161, 136),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: AssetImage(
                                subjectController.defaultSubjects[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Grade " +
                              subjectController.defaultSubjects[index].name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
