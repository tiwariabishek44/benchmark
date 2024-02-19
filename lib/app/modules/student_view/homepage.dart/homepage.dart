import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/buy_physical_items/item_list_view.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/note_controller.dart';
import 'package:benchmark/app/modules/common/buy_physical_items/inquary_page.dart';

import 'package:benchmark/app/widgets/switch_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final loginController = Get.put(LoginController());
  final storage = GetStorage();
  final noteContorller = Get.put(NoteController());
  bool isPurchased = false; // Initialize with the default value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Flex(
        direction: Axis.vertical,
        children: [
          // First Expanded Container (Flex 3)
          Expanded(
            flex: 3,
            child: Container(
              color: mainColor,
              child: Padding(
                padding: AppPadding.screenHorizontalPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi ${loginController.isLogedIn() ? 'Abishek ,' : 'Guest ,'}",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Let's Start Learning",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => PhysicalItemView(),
                                      transition: Transition.rightToLeft,
                                      duration: duration);
                                },
                                child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: backgroundColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            color: mainColor,
                                          ),
                                          Text(
                                            "Book/Notes",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: mainColor),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      gapH32,
                      Obx(
                        () => Container(
                          height: 5.7.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 195, 212, 195),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    noteContorller.selectedTopic.value = 0;
                                  },
                                  child: selectedTopics(
                                      'Streams',
                                      noteContorller.selectedTopic.value == 0
                                          ? whiteColor
                                          : Colors.transparent,
                                      noteContorller.selectedTopic.value == 0
                                          ? mainColor
                                          : blackColor)),
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    noteContorller.selectedTopic.value = 1;
                                  },
                                  child: selectedTopics(
                                      "MCQ's",
                                      noteContorller.selectedTopic.value == 1
                                          ? whiteColor
                                          : Colors.transparent,
                                      noteContorller.selectedTopic.value == 1
                                          ? mainColor
                                          : blackColor)),
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    noteContorller.selectedTopic.value = 2;
                                  },
                                  child: selectedTopics(
                                      'Recent',
                                      noteContorller.selectedTopic.value == 2
                                          ? whiteColor
                                          : Colors.transparent,
                                      noteContorller.selectedTopic.value == 2
                                          ? mainColor
                                          : blackColor)),
                            ),
                          ]),
                        ),
                      )
                    ]),
              ),
            ),
          ),

          // Second Expanded Container (Flex 7)
          Expanded(
            flex: 7,
            child: Obx(() => Container(
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: AppPadding.screenHorizontalPadding,
                    child: SwitchCaseWidget(
                      selectedTopic: noteContorller.selectedTopic.value,
                    ),
                  ),
                )),
          ),
        ],
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
              color: textColor,
              fontSize: 17.sp,
            ),
          ),
        ));
  }
}
