import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late Stream<DocumentSnapshot<Map<String, dynamic>>>? profileStream;
  MyProfileBloc _myProfileBloc = MyProfileBloc();
  @override
  void initState() {
    super.initState();
    profileStream = FirebaseFirestore.instance
        .collection('users')
        .where('uuid', isEqualTo: uUid)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MyProfileBloc, MyProfileState>(
        bloc: _myProfileBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MyProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyProfileLoadedState) {
            return Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        child: Image.network(
                          '',
                          height: 400.00,
                          fit: BoxFit.cover,
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
                              name,
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                phone,
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
                      infoWidget("Email", "abc@gmail.com"),
                      infoWidget("Education", "MCA"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoWidget("City", "Pune"),
                      infoWidget("Passout Year ", "2021"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoWidget("Refferal ID  ", "IOH281"),
                    ],
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Future<void> getUUID() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var uuid = await _prefs.getString('uuid');
    setState(() {
      uUid = uuid!;
    });
  }
}
