import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(19.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            heading,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: mainColor),
          )),
    );
  }
}
