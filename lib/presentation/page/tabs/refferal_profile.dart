

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class RefferalProfile extends StatefulWidget {
  final String uuid;
  const RefferalProfile({Key? key, required this.uuid}) : super(key: key);

  @override
  State<RefferalProfile> createState() => _RefferalProfileState();
}

class _RefferalProfileState extends State<RefferalProfile> {
  late String name = "";
  late String phone = "";
  late Stream<DocumentSnapshot<Map<String, dynamic>>>? profileStream;

  @override
  void initState() {
    super.initState();
    profileStream = FirebaseFirestore.instance
        .collection('users')
        .where('uuid', isEqualTo: widget.uuid)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: profileStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data?.data();
            if (data != null) {
              name = data['name'];
              phone = data['phone'];
              final profileUrl = data['profileUrl'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 5,
                            color: Colors.blue,
                          ),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: profileUrl == null
                            ? const Icon(
                                Icons.person,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Animate(
                                  effects:const  [
                                    FadeEffect(
                                      duration: Duration(milliseconds: 200),
                                    ),
                                  ],
                                  child: Image.network(
                                    profileUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                              phone,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('No data found');
            }
          }
        },
      ),
    );
  }
}
