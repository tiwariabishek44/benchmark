import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/all_Subject/all_subject_page.dart';
import 'package:benchmark/app/modules/common/all_Subject/subject_controller.dart';
import 'package:benchmark/app/modules/common/all_Subject/note_controller.dart';
import 'package:benchmark/app/widgets/batch_lable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SubjectList extends StatelessWidget {
  SubjectList({Key? key});
  final noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: false,
        physics: ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: allStreams.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            onTap: () {
              Get.to(
                  () => AllSubjectPage(
                        title: allStreams[index].name,
                        subject: allStreams[index].subjects,
                      ),
                  duration: duration,
                  transition: Transition.rightToLeft);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: greyColor,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(allStreams[index].image)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allStreams[index].name,
                            textAlign: TextAlign
                                .center, // Centers text within the container
                            style: TextStyle(
                              color: mainColor,
                              fontFamily: FontStyles.poppins,
                              fontSize: 17.sp, // Use screenutil for font sizing
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const BatchLabel(
                            iconColor: Colors.amber,
                            iconData: Icons.book,
                            labelText: '7 subject',
                            textColor: blackColor,
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          );
        });
  }
}
