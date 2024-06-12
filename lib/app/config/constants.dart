import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Duration duration = const Duration(milliseconds: 360);

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
class Sizes {
  static const p2 = 2.0;
  static const p10 = 10.0;
   
}
 
/// Constant gap widths
const gapH2 = SizedBox(height: Sizes.p2);
const gapH10 = SizedBox(height: Sizes.p10); 

class AppPadding {
  static EdgeInsetsGeometry get screenHorizontalPadding {
    return EdgeInsets.symmetric(horizontal: 4.w);
  }
}
