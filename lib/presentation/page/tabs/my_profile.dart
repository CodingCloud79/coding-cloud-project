import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:flutter_application_1/presentation/widgets/my_profile_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late String name = "";
  late String phone = "";
  late String uUid = "";
  late Map<String, dynamic> profileData = {};
  MyProfileBloc _myProfileBloc = MyProfileBloc();
  @override
  void initState() {
    super.initState();
    getUUID();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  child: profileData['profileUrl'] == null
                      ? const Icon(
                          Icons.person,
                          size: 400,
                        )
                      : 
                      Animate(
                          effects: const [
                            MoveEffect(
                              begin: Offset(0, -50),
                              end: Offset(0, 0),
                              duration: Duration(milliseconds: 500)
                            ),
                            FadeEffect(duration: Duration(milliseconds: 500))
                          ],
                          child: 
                           Hero(
                            tag: 'profileImage',
                            child: Image.network(
                              profileData['profileUrl'],
                              height: 400.00,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF8AD9FF),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      top: 48,
                      left: 16,
                      right: 16,
                    ),
                    height: 32,
                    width: 32,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: Icon(
                        size: 32,
                        Icons.chevron_left_outlined,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileData['name'] ?? " ",
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          profileData['phone'] ?? " ",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoWidget("Email", profileData['email'] ?? " "),
                infoWidget("Education", profileData['education'] ?? " "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoWidget("City", profileData['city'] ?? " "),
                infoWidget(
                    "Passout Year ", profileData['passoutYear'] ?? " "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoWidget("Refferal ID  ", profileData['refferalID'] ?? " "),
                infoWidget("City  ", profileData['city'] ?? " "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoWidget("State  ", profileData['state'] ?? " "),
                infoWidget("Address", profileData['address'] ?? " "),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUUID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var uuid = await _prefs.getString('uuid');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('uuid', isEqualTo: uuid)
        .get();
    print(querySnapshot.docs.first.data());
    setState(() {
      profileData = querySnapshot.docs.first.data();
    });
  }
}
