import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LearnCourses extends StatefulWidget {
  const LearnCourses({super.key});

  @override
  State<LearnCourses> createState() => _LearnCoursesState();
}

class _LearnCoursesState extends State<LearnCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Animate(
            effects: [ScaleEffect(duration: Duration(milliseconds: 300))],
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(textAlign: TextAlign.center, " Course "),
                ),
              ],
            ),
          )),
    );
  }
}
