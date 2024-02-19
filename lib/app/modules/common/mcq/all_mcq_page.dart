import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/modules/common/recent_viewes/recent_views_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllMcqs extends StatefulWidget {
  AllMcqs({Key? key});

  @override
  State<AllMcqs> createState() => _AllMcqsState();
}

class _AllMcqsState extends State<AllMcqs> {
  final recentController = Get.put(RecentViewsController());
  final pdfController = Get.put(PdfController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _buildListTile(context, index),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(3),
        tileColor: backgroundColor,
        onTap: () {
          pdfController.fetchPdf(
              "https://www.spaceportassociates.com/pdf/tourism_history.pdf");
          Get.to(
              () => PDFScreen(
                  title: "MCQ's ${index + 1}",
                  pdfUrl:
                      "https://www.spaceportassociates.com/pdf/tourism_history.pdf"),
              transition: Transition.rightToLeft,
              duration: duration);
        },
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: mainColor,
          ),
          child: Center(
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          "Physics 2080 Mcq's ${index + 1}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "2078", // Add your subtitle here
          style: TextStyle(
            color: blackColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
