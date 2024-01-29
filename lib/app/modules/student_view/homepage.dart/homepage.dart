import 'dart:developer';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/student_view/app_setting/app_setting.dart';
import 'package:benchmark/app/modules/student_view/buy_physical_items/buying_page.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/homepage_controller.dart';
import 'package:benchmark/app/widgets/category.dart';
import 'package:benchmark/app/widgets/subject_List.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key});
  final storage = GetStorage();
  final subjectController = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section
              Container(
                height: 20.5.h,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 55, 116, 92),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                padding: EdgeInsets.only(top: 26.0, left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left half with "Benchmark"

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi Guest,',
                                // Centers text within the container
                                style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: FontStyles.poppins,
                                  fontSize:
                                      23.sp, // Use screenutil for font sizing
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Let's Start Learning",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize:
                                      17.sp, // Use screenutil for font sizing
                                ),
                              ),
                            ],
                          ),
                          // Right top corner login button with curved edge boundary
                          storage.read(isLogin) != 'isLogin'
                              ? Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors
                                            .white), // Change color as needed
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => LoginOptionView(),
                                            transition: Transition.leftToRight);
                                        // Add your login button logic here
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 64, 59, 59)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: IconButton(
                                        onPressed: () {
                                          // dashboardcontroller.fetchAllProduct();
                                          // UserProductController().fetchUserProdcut();
                                          Get.to(() => AppSettings(),
                                              transition:
                                                  Transition.leftToRight);
                                        },
                                        icon: Icon(
                                          Icons.settings,
                                          color: blackColor,
                                          size: 19.sp,
                                        )),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // GridView with 5 containers

              CategoryWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Text(
                      "All Subject",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),

              // Replace the Expanded with a ListView.builder
              SubjectList(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        splashColor: Colors.amber,
        backgroundColor: Colors.amber,
        onPressed: () {
          Get.to(() => BuyingPage(), transition: Transition.leftToRight);
          // Add your onPressed action here
          // This is the action that will be performed when the button is clicked
        },
        icon: Icon(Icons.shopping_cart),
        label: Text(
          'Buy Book/Notes',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
