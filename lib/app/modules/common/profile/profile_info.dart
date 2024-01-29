import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileInfo extends StatelessWidget {
  String text;
  Widget iconWidget;
  ProfileInfo(this.text, this.iconWidget);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            iconWidget,
            SizedBox(
              width: 8.w,
            ),
            Text(
              text,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
