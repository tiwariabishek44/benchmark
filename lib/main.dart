import 'dart:async';
import 'dart:io';

import 'package:benchmark/app/modules/student_view/homepage.dart/homepage.dart';
import 'package:benchmark/app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Disable screenshots and screen recording on Android

void main() async {
  // Initialize the Nepali locale data
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  //  // Initialize Firebase
  await GetStorage.init(); // Initialize GetStorage

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        // Use Builder to get context inside the builder
        return Builder(
          builder: (context) {
            return GetMaterialApp(
              title: 'BenchMark',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // Check connectivity status to determine which screen to show
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
