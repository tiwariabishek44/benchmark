import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:benchmark/app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  // Initialize the Nepali locale data
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

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
              scaffoldMessengerKey: CustomSnackBar.scaffoldMessengerKey,

              title: 'BenchMark',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: backgroundColor,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  color: backgroundColor, //<-- SEE HERE
                ),
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
