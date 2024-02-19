import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/config/prefs.dart';
import 'package:benchmark/app/modules/common/buy_physical_items/inquary_page.dart';
import 'package:benchmark/app/modules/common/all_Subject/course_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/subject_controller.dart';
import 'package:benchmark/app/modules/student_view/note_list/note_list.dart';
import 'package:benchmark/app/modules/teacher_view/teacher_not_list/teacher_notes_list.dart';
import 'package:benchmark/app/widgets/batch_lable.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhysicalItemView extends StatelessWidget {
  PhysicalItemView({
    Key? key,
  });
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(title: "Buy Physical Books/Notes"),
        body: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: GridView.builder(
              physics: ScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => InquiryPage(
                          bookname: '11 physics',
                          price: 100,
                          image:
                              'https://www.oasispublication.com.np/uploads/sci-1.jpg',
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(1, 1))
                        ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              child: ClipRRect(
                                // Use ClipRRect to ensure that the curved corners are applied
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://www.oasispublication.com.np/uploads/sci-1.jpg' ??
                                          '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline, size: 40),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Book Name",
                                  textAlign: TextAlign
                                      .center, // Centers text within the container
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: FontStyles.poppins,
                                    fontSize:
                                        17.sp, // Use screenutil for font sizing
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs.400",
                                  textAlign: TextAlign
                                      .center, // Centers text within the container
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: mainColor,
                                    fontFamily: FontStyles.poppins,
                                    fontSize:
                                        15.sp, // Use screenutil for font sizing
                                  ),
                                ),
                                gapH10,
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 1))
                                      ]),
                                  height: 5.h,
                                  child: Center(
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Send Inquiry",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: whiteColor),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: whiteColor,
                                      )
                                    ],
                                  )),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                );
              }),
        ));
  }
}
