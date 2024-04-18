import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/inquary/inquary_page.dart';
import 'package:benchmark/app/modules/common/physical_items/physical_Items_controller.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PhysicalItemView extends StatelessWidget {
  PhysicalItemView({
    Key? key,
  });
  final storage = GetStorage();
  final physicalItemController = Get.put(PhysicalItemController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: "Buy Physical Books/Notes"),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Obx(() {
          if (physicalItemController.isMcqLoading.value) {
            return const Center(
                child: SpinKitChasingDots(
              size: 20,
              color: AppColors.mainColor,
            ));
          } else {
            if (!physicalItemController.isloded.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Products Yet',
                    ),
                    IconButton(
                        onPressed: () async {
                          physicalItemController.getPhysicalItems();
                        },
                        icon: physicalItemController.isMcqLoading.value
                            ? CircularProgressIndicator()
                            : Icon(Icons.refresh))
                  ],
                ),
              );
            } else {
              return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: physicalItemController
                      .physicalItemresponse.value.response!.data.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 3.h,
                  ),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                            () => InquiryPage(
                                bookid: physicalItemController
                                    .physicalItemresponse
                                    .value
                                    .response!
                                    .data[index]
                                    .id!,
                                bookname: physicalItemController
                                    .physicalItemresponse
                                    .value
                                    .response!
                                    .data[index]
                                    .name
                                    .toString(),
                                price: physicalItemController
                                    .physicalItemresponse
                                    .value
                                    .response!
                                    .data[index]
                                    .price
                                    .toString(),
                                image: physicalItemController
                                    .physicalItemresponse
                                    .value
                                    .response!
                                    .data[index]
                                    .fileLocation!),
                            transition: Transition.rightToLeft,
                            duration: duration);
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: CachedNetworkImage(
                                    imageUrl: ApiEndpoints.baseUrl +
                                        physicalItemController
                                            .physicalItemresponse
                                            .value
                                            .response!
                                            .data[index]
                                            .fileLocation!,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error_outline, size: 40),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      physicalItemController
                                          .physicalItemresponse
                                          .value
                                          .response!
                                          .data[index]
                                          .name!,
                                      textAlign: TextAlign
                                          .center, // Centers text within the container
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: FontStyles.poppins,
                                        fontSize: 17
                                            .sp, // Use screenutil for font sizing
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Rs.${physicalItemController.physicalItemresponse.value.response!.data[index].price}",
                                      textAlign: TextAlign
                                          .center, // Centers text within the container
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: FontStyles.poppins,
                                        fontSize: 15
                                            .sp, // Use screenutil for font sizing
                                      ),
                                    ),
                                    gapH10,
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(1, 1))
                                          ]),
                                      height: 5.h,
                                      child: Center(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Send Inquiry",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    AppColors.backgroundColor),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.backgroundColor,
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
                  });
            }
          }
        }),
      ),
    );
  }
}
