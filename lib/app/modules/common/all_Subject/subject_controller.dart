import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stream {
  final String name;
  final String image;
  final Color color; // Added gradient field for stream color

  Stream({
    required this.name,
    required this.image,
    required this.color,
  });
}

List<Stream> allStreams = [
  // Add class 11 science streams
  Stream(
    color: Color.fromARGB(255, 6, 143, 111),
// Assign a gradient for the stream color

    image: 'assets/11science.png',
    name: '11 science',
  ),
  // Add class 12 science streams
  Stream(
    color: Color.fromARGB(
        255, 32, 45, 225), // Assign a gradient for the stream color

    image: 'assets/12science.jpg',
    name: '12 science',
  ),
  // Add class 11 management streams
  Stream(
    color: Color.fromARGB(255, 240, 41, 51),
    image: 'assets/11management.jpg',
    name: '11 management',
  ),
  // Add class 12 management streams
  Stream(
    color: const Color.fromARGB(255, 34, 255, 159),
    image: 'assets/12science.jpg',
    name: '12 management',
  ),
  // Add more streams as needed
];
