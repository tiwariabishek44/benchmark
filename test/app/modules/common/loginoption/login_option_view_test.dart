import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_controller.dart';
import 'package:benchmark/app/modules/common/loginoption/login_option_view.dart';
import 'package:benchmark/app/modules/common/register/register.dart';
import 'package:benchmark/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  testWidgets('To check whethere the As teacher/ As student appear or not',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(home: LoginOptionView());
        },
      ),
    ); //

    //---------AS we have the timer duration in the Splash Screen
    await tester.pump(Duration(seconds: 3));

    expect(find.text('As Student'), findsOneWidget);
    expect(find.text('As Teacher'), findsOneWidget);
  });

  testWidgets(
      'To check whether the value of UserType change or not when click on As Student/As Teacher',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    // Build our app and trigger a frame.
    final loginOptionController = Get.put(LoginOptionController());

    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(home: LoginOptionView());
        },
      ),
    );
    await tester.pump(Duration(seconds: 3));

    await tester.tap(find.text('As Student'));
    await tester.pump();
    expect(loginOptionController.isUser.value, true);

    await tester.tap(find.text('As Teacher'));
    await tester.pump();
    expect(loginOptionController.isUser.value, false);
  });

  testWidgets(' To check Whethere the login Screen is there or not ',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(home: LoginOptionView());
        },
      ),
    );
    await tester.pump(Duration(seconds: 3));

    final findLoginScreen = find.byType(LoginScreen);
    expect(findLoginScreen, findsOneWidget);
    expect(find.byKey(Key('Email')), findsOneWidget);

    expect(find.byKey(Key('Password')), findsOneWidget);
  });

  testWidgets(' To Check whether the Register page open  or not',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(home: LoginOptionView());
        },
      ),
    );
    await tester.pump(Duration(seconds: 3));

    final loginButton = find.byKey(Key('loginButton'));
    expect(loginButton, findsOneWidget);

    final registerButton = find.byKey(Key('register'));
    expect(registerButton, findsOneWidget);

    await tester.tap(find.byKey(Key('register')));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage),
        findsOneWidget); // Check if RegisterPage is rendered
  });
}
