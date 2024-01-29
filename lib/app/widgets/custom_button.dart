import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  final bool isloaidng;
  String text;

  CustomButton(
      {required this.onPressed, required this.text, required this.isloaidng});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            minimumSize: Size(double.infinity, 6.5.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        child: isloaidng
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ));
  }
}
