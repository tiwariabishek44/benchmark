import 'dart:developer';

import 'package:benchmark/app/config/constants.dart';

import 'package:benchmark/app/modules/common/manual/mannual_controller.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_view_page.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:benchmark/app/widgets/no_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class MannualList extends StatelessWidget {
  MannualList({super.key, required this.title});
  final String title;
  final mannualController = Get.put(MannualController());
  final pdfController = Get.put(PdfController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
      ),
      body: Obx(
        () {
          if (mannualController.isLoading.value) {
            return LoadingScreen();
          } else {
            if (mannualController.mannualLoaded.value) {
              return Stack(
                children: [
                  Column(children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mannualController
                          .mannualResponse.value.response?.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {

                                log(" this is the mannual location :::::::${dotenv.get('BASE_URL')}${mannualController.mannualResponse.value.response?.data[index].fileLocation}");
                                pdfController.fetchPdf(dotenv.get('BASE_URL') +
                                    mannualController.mannualResponse.value
                                        .response!.data[index].fileLocation!);
                                pdfController.enableSwipe.value = true;

                                Get.to(
                                    () => PDFScreen(
                                        title:
                                            "${mannualController.mannualResponse.value.response?.data[index].name}",
                                        pdfUrl: dotenv.get('BASE_URL') +
                                            mannualController
                                                .mannualResponse
                                                .value
                                                .response!
                                                .data[index]
                                                .fileLocation!),
                                    duration: duration,
                                    transition: Transition.rightToLeft);
                              },
                              title: Text(
                                "${mannualController.mannualResponse.value.response?.data[index].name}",
                                style: TextStyle(
                                  fontSize: 18, // Adjust as needed
                                  color: Colors
                                      .black, // or any other color you prefer
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the curve radius
                              ),
                              tileColor: Color.fromARGB(255, 228, 228,
                                  228), // Use Colors.lightGrey for light grey color
                            ));
                      },
                    ),
                  ]),
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
}
