import 'package:benchmark/app/modules/common/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify email input field work or not',
      (WidgetTester tester) async {
    // Build the calculator screen widget
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    final emailInputBox = find.byKey(const Key('emailInputField'));
    await tester.pump();
    expect(emailInputBox, findsOneWidget);
  });
}
