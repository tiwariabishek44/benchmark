import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_page.dart';
import 'package:benchmark/app/modules/common/recent_viewes/recent_views_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentViewsScreen extends StatelessWidget {
  final recentViewsController = Get.put(RecentViewsController());
  String firstCharacter(String input) {
    // Split the input string by space
    List<String> parts = input.split(' ');

    // Get the second part (assuming there is a space and another part)
    String secondPart = parts.length > 1 ? parts[1] : '';

    // Get the first character of the second part
    String firstCharacter = secondPart.isNotEmpty ? secondPart[0] : '';

    return firstCharacter;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Obx(() {
        if (recentViewsController.items.isEmpty) {
          return Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Text("You haven't studied yet !"),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: false,
            physics: ScrollPhysics(),
            itemCount: recentViewsController.items.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(3),
                      tileColor: backgroundColor,
                      onTap: () {
                        Get.to(
                            () => PDFScreen(
                                  title:
                                      recentViewsController.items[index].stream,
                                  pdfUrl:
                                      "https://www.spaceportassociates.com/pdf/tourism_history.pdf",
                                ),
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
                            "${firstCharacter(recentViewsController.items[index].stream)}",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        recentViewsController.items[index].stream,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        recentViewsController
                            .items[index].noteName, // Add your subtitle here
                        style: TextStyle(
                          color: blackColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      bottom: 10,
                      child: Text(
                        "Continue Reading",
                        style: TextStyle(
                            color: Color.fromARGB(255, 30, 71, 15),
                            fontWeight: FontWeight.w500),
                      ))
                ],
              );
            },
          );
        }
      }),
    );
  }
}
