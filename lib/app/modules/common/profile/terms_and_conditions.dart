// TermsAndConditions Page

import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Your Education App Name. By accessing or using our app, you agree to abide by the following terms and conditions:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Account Usage:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Multiple logins from the same account are prohibited.',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              '2. Content Usage:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'The ability to take screenshots of the content is restricted.\n\n'
              'All content available on the app, including notes and textbooks, is protected by copyright laws.\n\n'
              'Users are prohibited from reproducing, distributing, or modifying any content without prior authorization.',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            // Add remaining points in a similar manner
          ],
        ),
      ),
    );
  }
}
