import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Subject {
  final String name;
  final String image;
  final LinearGradient gradient; // Add gradient field

  Subject({required this.name, required this.image, required this.gradient});
}

// subject_data.dart

// Class 11 Science Subjects
List<Subject> class11ScienceSubjects = [
  Subject(
    name: '11 Physics',
    image: 'assets/images.jpeg',
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
  // Add more subjects as needed
];

// Class 12 Science Subjects
List<Subject> class12ScienceSubjects = [
  Subject(
    name: '12 Physics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
  ),
  Subject(
    name: '12 Chemistry',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
  ),
  Subject(
    name: '12 Biology',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
  ),
  Subject(
    name: '12 Mathematics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
  ),
  Subject(
    name: '12 Computer Science',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
  ),
  // Add more subjects as needed
];

// Class 11 Management Subjects
List<Subject> class11ManagementSubjects = [
  Subject(
    name: '11 Accountancy',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
  ),
  Subject(
    name: '11 Business Studies',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
  ),
  Subject(
    name: '11 Economics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
  ),
  Subject(
    name: '11 Mathematics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
  ),
  Subject(
    name: '11 Computer',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
  ),
  // Add more subjects as needed
];

// Class 12 Management Subjects
List<Subject> class12ManagementSubjects = [
  Subject(
    name: '12 Accountancy',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
  ),
  Subject(
    name: '12 Business Studies',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
  ),
  Subject(
    name: '12 Economics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
  ),
  Subject(
    name: '12 Mathematics',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
  ),
  Subject(
    name: '12 Computer',
    image: 'assets/images.jpeg',
    gradient: LinearGradient(colors: [Colors.teal, Colors.lightBlue]),
  ),
  // Add more subjects as needed
];

class SubjectController extends GetxController {
  var stream = "11 Science".obs;
  var defaultSubjects = <Subject>[].obs; // Observable list

  var subjects = <Subject>[].obs; // Observable list

  @override
  void onInit() {
    super.onInit();
    defaultSubject(stream.value);
  }

  List<Subject> getSubjectsByCategory(String category) {
    switch (category) {
      case '11 Science':
        return class11ScienceSubjects;
      case '12 Science':
        return class12ScienceSubjects;
      case '11 Management':
        return class11ManagementSubjects;
      case '12 Management':
        return class12ManagementSubjects;
      // Add more cases as needed
      default:
        return [];
    }
  }

  void getSubject(String streams) {
    var currentStreamValue = streams;
    subjects.clear();
    subjects.assignAll(getSubjectsByCategory(currentStreamValue));
  }

  // Update subjects based on the stream value
  void defaultSubject(String streams) {
    stream.value = streams;
    var currentStreamValue = streams;
    defaultSubjects.clear();
    defaultSubjects.assignAll(getSubjectsByCategory(currentStreamValue));
  }
}
