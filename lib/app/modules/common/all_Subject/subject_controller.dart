import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stream {
  final String name;
  final String image;
  final List<Subject> subjects;
  final Color color; // Added gradient field for stream color

  Stream({
    required this.name,
    required this.subjects,
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
    name: '11 Science',
    subjects: [
      Subject(
        name: '11 Nepali',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '11 physics',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '11 Chemistry',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
      ),
      Subject(
        name: '11 Biology',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      ),
      Subject(
        name: '11 Mathematics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
      ),
      Subject(
        name: '11 Computer Science',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      // Add other subjects as needed
    ],
  ),
  // Add class 12 science streams
  Stream(
    color: Color.fromARGB(
        255, 32, 45, 225), // Assign a gradient for the stream color

    image: 'assets/12science.jpg',
    name: '12 Science',
    subjects: [
      Subject(
        name: '12 Nepali',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '12 Physics',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '12 Chemistry',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
      ),
      Subject(
        name: '12 Biology',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      ),
      Subject(
        name: '12 Mathematics',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
      ),
      Subject(
        name: '12 Computer Science',
        image: 'assets/chemistry12.jpg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      // Add other subjects as needed
    ],
  ),
  // Add class 11 management streams
  Stream(
    color: Color.fromARGB(255, 240, 41, 51),
    image: 'assets/11management.jpg',
    name: '11 Management',
    subjects: [
      Subject(
        name: '11 English',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '11 Nepali',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
      ),
      Subject(
        name: '11 Basic Mathematics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      ),
      Subject(
        name: '11 Accountancy',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
      ),
      Subject(
        name: '11 Economics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '11 Business Studies',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '11 Business Mathematics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '11 Computer Science',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      // Add other subjects as needed
    ],
  ),
  // Add class 12 management streams
  Stream(
    color: const Color.fromARGB(255, 34, 255, 159),
    image: 'assets/12science.jpg',
    name: '12 Management',
    subjects: [
      Subject(
        name: '12 English',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
      ),
      Subject(
        name: '12 Nepali',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
      ),
      Subject(
        name: '12 Basic Mathematics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      ),
      Subject(
        name: '12 Accountancy',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
      ),
      Subject(
        name: '12 Economics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '12 Business Studies',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '12 Business Mathematics',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      Subject(
        name: '12 Computer Science',
        image: 'assets/images.jpeg',
        gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
      ),
      // Add other subjects as needed
    ],
  ),
  // Add more streams as needed
];

class Subject {
  final String name;
  final String image;
  final LinearGradient gradient; // Add gradient field

  Subject({required this.name, required this.image, required this.gradient});
}
