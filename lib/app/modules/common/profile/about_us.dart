import 'package:flutter/material.dart';
import 'package:benchmark/app/config/color.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('About us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadowContainer(
              child: Text(
                'Welcome to Your Education App Name, your go-to destination for academic excellence. We\'re here to make learning easier, more accessible, and more rewarding for students everywhere.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ShadowContainer(
              child: Text(
                'At Your Education App Name, we understand the challenges students face in their academic journey. That\'s why we\'ve curated a comprehensive collection of notes and textbooks for every subject, meticulously crafted by experts in the field.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ShadowContainer(
              child: Text(
                'With our user-friendly interface and secure payment system, purchasing notes and textbooks is quick and hassle-free. Whether you\'re preparing for exams, seeking additional resources, or simply expanding your knowledge, we\'ve got you covered.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowContainer extends StatelessWidget {
  final Widget child;

  ShadowContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: child,
    );
  }
}
