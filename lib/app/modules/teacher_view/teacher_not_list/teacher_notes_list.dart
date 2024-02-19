import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/course_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/note_controller.dart';
import 'package:benchmark/app/modules/common/recent_viewes/recent_views_controller.dart';
import 'package:benchmark/app/widgets/batch_lable.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:benchmark/app/widgets/no_note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TeacherNotesList extends StatelessWidget {
  final String imagePath;

  TeacherNotesList({super.key, required this.imagePath});

  final noteContorller = Get.put(NoteController());
  final recentController = Get.put(RecentViewsController());
  final courseController = Get.put(CourseController());
  final pdfController = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (courseController.isLoading.value) {
              return const LoadingScreen();
            } else {
              if (courseController.courseResponse.value.response == null) {
                return const NoNotes();
              } else {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    // First Expanded Container (Flex 3)
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 33, 28, 28),
                              Color.fromARGB(255, 154, 149, 149),
                              Color.fromARGB(255, 216, 213, 213),
                              Color.fromARGB(255, 255, 255, 255),
                              Colors.white
                            ], // Adjust these colors as needed
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 11),
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: const FractionalOffset(
                              0.5, 0.8), // Adjust as needed
                          child: Stack(
                            children: [
                              Image.asset(
                                imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ), // Replace with your course image widget
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                    radius: 6.w,
                                    backgroundColor: backgroundColor,
                                    child: const Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 1.h,
                                left: 5.w,
                                right: 5.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      courseController
                                          .courseResponse.value.response!.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.6.h,
                                    ),
                                    Text(
                                      courseController.courseResponse.value
                                          .response!.description,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Display ellipsis (...) for overflow
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BatchLabel(
                                          iconColor: Colors.amber,
                                          textColor: whiteColor,
                                          iconData: Icons.note,
                                          labelText:
                                              '${courseController.courseResponse.value.response!.notes.length} Notes',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Second Expanded Container (Flex 7)
                    Expanded(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(1),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ],
                            color: whiteColor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30))),
                        width: double.infinity,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.w),
                            child: Obx(
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
                                          courseController
                                              .selectedTopics.value = 0;
                                        },
                                        child: selectedTopics(
                                            'All Notes',
                                            courseController
                                                        .selectedTopics.value ==
                                                    0
                                                ? mainColor
                                                : Colors.transparent,
                                            courseController
                                                        .selectedTopics.value ==
                                                    0
                                                ? whiteColor
                                                : blackColor)),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          courseController
                                              .selectedTopics.value = 1;
                                        },
                                        child: selectedTopics(
                                            "Description",
                                            courseController
                                                        .selectedTopics.value ==
                                                    1
                                                ? mainColor
                                                : Colors.transparent,
                                            courseController
                                                        .selectedTopics.value ==
                                                    1
                                                ? whiteColor
                                                : blackColor)),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Divider(),
                          courseController.selectedTopics.value == 0
                              ? Expanded(
                                  child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: courseController.courseResponse
                                      .value.response?.notes.length,
                                  itemBuilder: (context, index) {
                                    final Note? note = courseController
                                        .courseResponse
                                        .value
                                        .response
                                        ?.notes[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          recentController.addItem(
                                              courseController.courseResponse
                                                  .value.response!.name,
                                              'Note ${index + 1}',
                                              note.pdfUrl);

                                          pdfController.fetchPdf(note.pdfUrl);

                                          Get.to(
                                              () => PDFScreen(
                                                    title: note.title,
                                                    pdfUrl: note.pdfUrl,
                                                  ),
                                              duration: duration,
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child:
                                            _buildCardContent(context, note!),
                                      ),
                                    );
                                  },
                                ))
                              : SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(1, 1))
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 16.0),
                                          child: Text(
                                            courseController.courseResponse
                                                .value.response!.description
                                                .toString(), // Adjust as needed
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ]),
                      ),
                    ),
                  ],
                );
              }
            }
          },
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
                color: textColor, fontSize: 17.sp, fontWeight: FontWeight.w700),
          ),
        ));
  }

//
  Widget _buildCardContent(BuildContext context, Note note) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset('assets/pdf.jpg'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(fontSize: 16, color: blackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "@benchmark",
                  style: TextStyle(fontSize: 16, color: blackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
