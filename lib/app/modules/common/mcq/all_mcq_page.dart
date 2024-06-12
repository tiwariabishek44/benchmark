// TO DISPLAY THE LIST OF THE MCQ (FREE  AND ACCESS WITHOUT LOGIN )

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/modules/common/mcq/mcq_controller.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


 
class AllMcqs extends StatefulWidget {
  AllMcqs({Key? key});

  @override
  State<AllMcqs> createState() => _AllMcqsState();
}

class _AllMcqsState extends State<AllMcqs> {
  final pdfcontroller = Get.put(PdfController());

  final mcqController = Get.put(McqController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mcqController.isMcqLoading.value) {
        return const Center(
            child: SpinKitChasingDots(
          size: 20,
          color: AppColors.mainColor,
        ));
      } else {
        if (!mcqController.isloded.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Mcq's yet",
                ),
                IconButton(
                    onPressed: () async {
                      mcqController.getMcq();
                    },
                    icon: mcqController.isMcqLoading.value
                        ? CircularProgressIndicator()
                        : Icon(Icons.refresh))
              ],
            ),
          );
        } else {
          return ListView.builder(
            physics: ScrollPhysics(),
            itemCount: mcqController.mcqResponse.value.response!.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(3),
                  tileColor: AppColors.backgroundColor,
                  onTap: () {
                    pdfcontroller.fetchPdf(dotenv.get('BASE_URL') +
                        mcqController.mcqResponse.value.response!.data[index]
                            .fileLocation!);
                    pdfcontroller.enableSwipe.value = true;

                    Get.to(
                      () => PDFScreen(
                        title: mcqController
                            .mcqResponse.value.response!.data[index].name!,
                        pdfUrl: dotenv.get('BASE_URL') +
                            mcqController.mcqResponse.value.response!
                                .data[index].fileLocation!,
                      ),
                      transition: Transition.rightToLeft,
                    );
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    mcqController.mcqResponse.value.response!.data![index].name
                        .toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    mcqController.mcqResponse.value.response!.data![index]
                        .name!, // Add your subtitle here
                    style: TextStyle(
                      color: AppColors.iconColors,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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


