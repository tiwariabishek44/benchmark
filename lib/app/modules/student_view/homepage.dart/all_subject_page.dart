import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/homepage_controller.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/note_list.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/subject_List.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/pdf_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllSubjectPage extends StatelessWidget {
  final String title;
  AllSubjectPage({Key? key, required this.title});
  final subjectContorller = Get.put(SubjectController());
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: subjectContorller.subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                            () => NotesList(
                                  title: subjectContorller.subjects[index].name,
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
                                    image: AssetImage(subjectContorller
                                        .subjects[index].image),
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
                                  subjectContorller.subjects[index].name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
            })),
            ElevatedButton(
                onPressed: () {
                  subjectContorller.defaultSubject(title);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    minimumSize: Size(double.infinity, 6.5.h),
                    shape: RoundedRectangleBorder()),
                child: const Text(
                  'Set As Default',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ))
          ],
        ));
  }
}
