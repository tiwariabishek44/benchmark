import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/buy_physical_items/inquiry_controller.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/buy_physical_items/physical_Items_controller.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InquiryPage extends StatelessWidget {
  final String bookname;
  final String price;
  final String image;
  final int bookid;

  InquiryPage({
    required this.bookid,
    required this.bookname,
    required this.price,
    required this.image,
  });
  final loginController = Get.put(LoginController());

  final inquryController = Get.put(InquiryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: 'Send Inquiry',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: inquryController.formKey,
          child: Padding(
            padding: AppPadding.screenHorizontalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
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
                  height: 15.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Add a background color
                        ),
                        height: 15.h,
                        width: 30.w,
                        child: ClipRRect(
                          // Use ClipRRect to ensure that the curved corners are applied
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: ApiEndpoints.baseUrl + image ?? '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error_outline, size: 40),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bookname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: FontStyles.poppins,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              "Rs.$price",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.listTileTitle,
                            ),
                            Text('@benchmark',
                                style: AppStyles.listTilesubTitle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Your inqury is for: ${bookname}",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: mainColor),
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 4.h),
                    Text(
                      "To place an inquary for our books/notes in hardcopy, kindly complete this form. Our team member will reach out to you shortly.",
                      style: AppStyles.listTilesubTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    CustomizedTextfield(
                      myController: inquryController.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name.';
                        }
                        return null;
                      },
                      icon: Icons.person_outline,
                      hintText: "Name",
                    ),
                    CustomizedTextfield(
                      myController: inquryController.phoneContorlller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number.';
                        }
                        // You can add more specific validation logic here, such as regex validation for phone number format
                        return null;
                      },
                      icon: Icons.phone_android,
                      hintText: "Phone No.",
                    ),
                    SizedBox(height: 16),
                  ],
                ),
                CustomButton(
                  isLoading: false,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    inquryController.productInqury(bookid);
                  },
                  text: "Send Inquiry",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
