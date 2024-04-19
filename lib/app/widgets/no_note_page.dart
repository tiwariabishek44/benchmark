// TO DISPLAY INFORMATION WHEN THERE IS NO NOTES

import 'package:benchmark/app/config/app_style.dart';
import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/notnotes.jpg', // Replace with your image asset path
              width: 200, // Adjust image width as needed
              height: 200, // Adjust image height as needed
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8),
            child: Text(
              "No notes are available.",
              style: AppStyles.listTileTitle,
            ),
          ),
        ],
      ),
    );
  }
}
