import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/notnotes.jpg', // Replace with your image asset path
                  width: 200, // Adjust image width as needed
                  height: 200, // Adjust image height as needed
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 8),
                child: Text(
                  "No notes are available.",
                  style: AppStyles.listTileTitle,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 2.h,
          left: 3.w,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 6.w,
              backgroundColor: backgroundColor,
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}
