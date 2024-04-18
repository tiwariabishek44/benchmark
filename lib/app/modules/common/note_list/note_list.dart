import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/eSewa/esewa_function.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/model/api_response/my_course_response.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/modules/common/note_list/note_controller.dart';
import 'package:benchmark/app/modules/common/note_purchase/note_purchase_conformation_page.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:benchmark/app/widgets/no_note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_view_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotesList extends StatelessWidget {
  final String imagePath;
  final bool? isPurchaseCourse;
  final Datum data;

  // Constructor to receive the image path
  NotesList(
      {required this.imagePath, required this.data, this.isPurchaseCourse});
  Esewa esewa = Esewa();
  final storage = GetStorage();
  final noteContorller = Get.put(NoteController());
  final pdfController = Get.put(PdfController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: data.subject.toString(),
      ),
      body: Obx(
        () {
          if (noteContorller.isLoading.value) {
            return LoadingScreen();
          } else {
            if (noteContorller.noteLoaded.value) {
              return Stack(
                children: [
                  Column(children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: noteContorller
                          .courseResponse.value.response?.data.length,
                      itemBuilder: (context, index) {
                        final Book? note = noteContorller
                            .courseResponse.value.response?.data[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              if (note.bookType != 'PAID' ||
                                  storage.read(userType) == 'TEACHER' ||
                                  (isPurchaseCourse != null &&
                                      isPurchaseCourse!)) {
                                pdfController.fetchPdf(ApiEndpoints.baseUrl +
                                    noteContorller.courseResponse.value
                                        .response!.data[index].fileLocation!);
                                pdfController.enableSwipe.value = true;

                                Get.to(
                                    () => PDFScreen(
                                          title: data.subject.toString(),
                                          pdfUrl: ApiEndpoints.baseUrl +
                                              noteContorller
                                                  .courseResponse
                                                  .value
                                                  .response!
                                                  .data[index]
                                                  .fileLocation!,
                                        ),
                                    duration: duration,
                                    transition: Transition.rightToLeft);
                              } else {
                                _showUnlockMessage(context);
                              }
                            },
                            child: Stack(
                              children: [
                                _buildCardContent(context, note!),
                                note.bookType != 'PAID' ||
                                        storage.read(userType) == 'TEACHER' ||
                                        (isPurchaseCourse != null &&
                                            isPurchaseCourse!)
                                    ? Container()
                                    : Positioned(
                                        bottom: 3.h,
                                        right: 10,
                                        child: const Icon(
                                          Icons.lock,
                                          size: 24,
                                          color:
                                              Color.fromARGB(255, 33, 82, 145),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
                  storage.read(userType) == 'TEACHER' ||
                          (isPurchaseCourse != null && isPurchaseCourse!)
                      ? Container()
                      : Positioned(
                          bottom: 5.h,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: () {
                              storage.read(userType) != null
                                  ? Get.to(
                                      () => PurchaseCornformationPage(
                                            image: imagePath,
                                            totalNote: noteContorller
                                                .courseResponse
                                                .value
                                                .response!
                                                .data
                                                .length
                                                .toString(),
                                            data: data,
                                          ),
                                      transition: Transition.rightToLeft,
                                      duration: duration)
                                  : Get.to(() => LoginOptionView(),
                                      transition: Transition.rightToLeft,
                                      duration: duration);
                            },
                            child: Container(
                              height: 5.7.h,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Center(
                                  child: Text(
                                    'Buy Now (Bundle Rs.${data.price})',
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color:
                                            Color.fromARGB(255, 233, 239, 233)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              );
            } else {
              return const NoNotes();
            }
          }
        },
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
  Widget _buildCardContent(BuildContext context, Book note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20), // Adjust the radius as needed
          border: Border.all(
            color: const Color.fromARGB(255, 222, 217, 217),
            width: 2,
          ),
        ),
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
                    note.name!,
                    style: TextStyle(fontSize: 16, color: AppColors.iconColors),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "@benchmark",
                    style: TextStyle(fontSize: 16, color: AppColors.iconColors),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnlockMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                Icon(
                  Icons.lock_open,
                  size: 30.sp,
                  color: Colors.red,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Unlock Content',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Purchase this course to unlock all notes .',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
