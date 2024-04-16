import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/eSewa/esewa_function.dart';
import 'package:benchmark/app/model/api_response/course_response_model.dart';
import 'package:benchmark/app/model/api_response/my_course_response.dart';
import 'package:benchmark/app/modules/common/note_list/purchase_controller.dart';
import 'package:benchmark/app/utils/token_util.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:benchmark/app/widgets/payment_succesfull.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PurchaseCornformationPage extends StatelessWidget {
  PurchaseCornformationPage(
      {super.key,
      required this.data,
      required this.totalNote,
      required this.image});
  final Esewa esewa = Esewa();
  final Datum data;
  final String totalNote;
  final String image;
  final storage = GetStorage();
  final purchaseController = Get.put(PurchaseControler());

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
            Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(5)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: greyColor,
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: AssetImage(image)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
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
                                data.subject!,
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
                                'Total: $totalNote Notes',
                                style: TextStyle(
                                  color: greyColor,
                                  fontFamily: FontStyles.poppins,
                                  fontSize:
                                      15.sp, // Use screenutil for font sizing
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
                                  fontSize:
                                      15.sp, // Use screenutil for font sizing
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Payment  ",
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
                        'Total:Rs.${data.price}',
                        style: TextStyle(color: mainColor, fontSize: 18.sp),
                      ),
                      Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset('assets/esewa.png'),
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
                // purchaseController.buyCourse(courseId: data.id.toString());
                esewa.pay(data.id.toString(), data.price.toString(),
                    data.subject.toString());
              },
              text: "Continue",
            )
          ]),
        ),
      ),
    );
  }
}
