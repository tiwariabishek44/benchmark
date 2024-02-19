import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
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
  final double price;
  final String image;

  InquiryPage({
    required this.bookname,
    required this.price,
    required this.image,
  });
  final loginController = Get.put(LoginController());

  final buyItemController = Get.put(BuyItemController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: 'Send Inquiry',
      ),
      body: Form(
        key: buyItemController.formKey,
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
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white, // Add a background color
                      ),
                      height: 15.h,
                      width: 30.w,
                      child: ClipRRect(
                        // Use ClipRRect to ensure that the curved corners are applied
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: image ?? '',
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
                          Text('@benchmark', style: AppStyles.listTilesubTitle),
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
                "Your inqury is for ${bookname} book",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: mainColor),
                textAlign: TextAlign.center,
              ),
              loginController.isLogedIn()
                  ? SizedBox()
                  : Container(
                      color: Colors.white, // Set your desired background color
                      child: Form(
                        child: Column(
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
                              validator: (value) {},
                              icon: Icons.person_outline,
                              hintText: "Name",
                            ),
                            CustomizedTextfield(
                              validator: (value) {},
                              icon: Icons.phone_android,
                              hintText: "Phone No.",
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
              CustomButton(
                isLoading: false,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                text: "Send Inquiry",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
