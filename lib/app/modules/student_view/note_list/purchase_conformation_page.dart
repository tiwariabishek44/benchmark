import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/eSewa/esewa_function.dart';
import 'package:benchmark/app/widgets/batch_lable.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PurchaseCornformationPage extends StatelessWidget {
  PurchaseCornformationPage({super.key});
  final Esewa esewa = Esewa();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'Order Summary'),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(5)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/logo.png')),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Physic Grade 11',
                          textAlign: TextAlign
                              .center, // Centers text within the container
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: FontStyles.poppins,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Total: 4 Notes',
                          style: TextStyle(
                            color: greyColor,
                            fontFamily: FontStyles.poppins,
                            fontSize: 15.sp, // Use screenutil for font sizing
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '@BenchMark',
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: FontStyles.poppins,
                            fontSize: 15.sp, // Use screenutil for font sizing
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Payment ",
              textAlign: TextAlign.left,
              style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontStyles.medium700),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:Rs.500',
                        style: TextStyle(color: mainColor, fontSize: 18.sp),
                      ),
                      Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  'assets/esewa.png',
                                ))),
                        width: 25.w,
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomButton(
              isLoading: false,
              onPressed: () {
                FocusScope.of(context).unfocus();
                esewa.pay();
              },
              text: "Continue",
            )
          ]),
        ),
      ),
    );
  }
}
