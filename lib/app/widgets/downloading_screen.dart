// DOWNLOADING SCREEN WHILE PDF IS LOAIDNG

import 'dart:ui';

import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DownloadingScreen extends StatelessWidget {
  const DownloadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        // Loading indicator and content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon representing download
              Icon(
                Icons.cloud_download,
                size: 50,
                color: AppColors.mainColor,
              ),
              SizedBox(height: 20),
              // Customizable content, e.g., text
              Text(
                'Loading PDF...',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              // Loading indicator
              SpinKitFadingCircle(
                color: AppColors.mainColor,
              ),
              SizedBox(height: 20),
              // Customizable image
            ],
          ),
        ),
      ],
    );
  }
}
