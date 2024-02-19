import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BatchLabel extends StatelessWidget {
  final IconData iconData;
  final String labelText;
  final Color iconColor;
  final Color textColor;

  const BatchLabel(
      {Key? key,
      required this.iconData,
      required this.labelText,
      required this.iconColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
          SizedBox(width: 2),
          Text(
            labelText,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
