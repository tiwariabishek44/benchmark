//BOTTOM NAVIGATION FOR THE STUDENT

import 'dart:developer';

import 'package:benchmark/app/modules/common/homepage.dart/homepage.dart';
import 'package:benchmark/app/modules/student_view/my_course/my_course_page.dart';
import 'package:benchmark/app/modules/student_view/student_main_screen/user_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StudentMainScreenView extends StatelessWidget {
  StudentMainScreenView({Key? key});

  final userController = Get.put(UserScreenController());

  final List<Widget> pages = [
    TeacherHomePage(),
    MyCoursePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => PageStorage(
            bucket: userController.bucket,
            child: userController.currentScreen.value,
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(
                      255, 210, 207, 207), // Specify your desired border color
                  width: 0.50, // Specify the border width
                ),
              ),
            ),
            height: 7.5.h,
            child: MyBottomNavigationBar(
              currentIndex: userController.currentTab.value,
              onTap: (index) {
                userController.currentTab.value = index;
                userController.currentScreen.value = pages[index];
              },
              items: [
                MyBottomNavigationBarItem(
                    nonSelectedicon: Icons.home_outlined,
                    icon: Icons.home,
                    label: 'Home'),
                MyBottomNavigationBarItem(
                    nonSelectedicon: Icons.shopping_cart_outlined,
                    icon: Icons.shopping_cart,
                    label: 'MyCourse'),
              ],
            ),
          ),
        ));
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MyBottomNavigationBarItem> items;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        var index = items.indexOf(item);
        return Expanded(
          child: InkWell(
            onTap: () => onTap(index),
            splashColor: Colors.transparent, // Disable tap effect

            child: item.build(index == currentIndex),
          ),
        );
      }).toList(),
    );
  }
}

class MyBottomNavigationBarItem {
  final IconData icon;
  final IconData nonSelectedicon;

  final String label;

  MyBottomNavigationBarItem({
    required this.nonSelectedicon,
    required this.icon,
    required this.label,
  });

  Widget build(bool isSelected) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? icon : nonSelectedicon,
            color: isSelected
                ? Colors.black
                : const Color.fromARGB(255, 69, 67, 67),
            // Outline the icon if not selected
            size: 21.0.sp,
            semanticLabel: label,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: isSelected
                  ? Colors.black
                  : const Color.fromARGB(255, 69, 67, 67),
            ),
          ),
        ],
      ),
    );
  }
}
