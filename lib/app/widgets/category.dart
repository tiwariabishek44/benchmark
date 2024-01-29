import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/all_subject_page.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});
}

class CategoryWidget extends StatelessWidget {
  final subjectcontroller = Get.put(SubjectController());
  List<Category> categories = [
    Category(name: '11 Science', image: 'assets/momentum.png'),
    Category(name: '12 Science', image: 'assets/momentum.png'),
    Category(name: '11 Management', image: 'assets/momentum.png'),
    Category(name: '12 Management', image: 'assets/momentum.png'),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                subjectcontroller.getSubject(categories[index].name);
                Get.to(() => AllSubjectPage(
                      title: categories[index].name,
                    ));
              },
              child: CategoryItem(
                category: categories[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(category.image),
                fit: BoxFit.fill,
              ),
            ),
            width: 40.0,
            height: 40.0,
          ),
          SizedBox(width: 8.0),
          Text(
            category.name,
            style: TextStyle(
              color: greyColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
