import 'package:benchmark/app/modules/student_view/homepage.dart/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreenController extends GetxController {
  var currentTab = 0.obs;
  final PageStorageBucket bucket = PageStorageBucket();
  Rx<Widget> currentScreen = Rx<Widget>(Homepage());
}
