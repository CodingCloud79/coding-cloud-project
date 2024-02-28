import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 133, 184, 209),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
