import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/material.dart';

class OnbardingPage extends StatelessWidget {
  const OnbardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: mainColor,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0), // Adjust the radius as needed
                  topRight:
                      Radius.circular(50.0), // Adjust the radius as needed
                ),
              ),
              child: Column(children: []),
            ),
          ),
        ],
      ),
    );
  }
}
