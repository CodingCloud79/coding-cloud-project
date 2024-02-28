import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_application_1/presentation/page/tabs/home_screen_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/refferal_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConnects extends StatefulWidget {
  final String id;
  const MyConnects({super.key, required this.id});

  @override
  State<MyConnects> createState() => _MyConnectsState();
}

class _MyConnectsState extends State<MyConnects> {
  late List<Map<String, dynamic>> myConnects = [];

  @override
  void initState() {
    // TODO: implement initState
    fetctMyConnects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: RefreshIndicator(
              onRefresh: fetctMyConnects,
              child: myConnects.isEmpty
                  ? const Center(child: Text("No Refferals "))
                  : ListView.builder(
                      itemCount: myConnects.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RefferalProfile(
                                    uuid: myConnects[index]['uuid']),
                              ),
                            );
                          },
                          child: Animate(
                            effects: const [
                              SlideEffect(),
                              FadeEffect(),
                            ],
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.black38,
                                  ),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:  [
                                    BoxShadow(
                                      color: Colors.grey[400]!,
                                      offset: Offset(0, 8),
                                      blurRadius: 10,
                                      spreadRadius: -4
                                    )
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      myConnects[index]['profileUrl'],
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myConnects[index]['name'],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        myConnects[index]['phone'],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetctMyConnects() async {
    QuerySnapshot snapshotS = await FirebaseFirestore.instance
        .collection('users')
        .where('uuid', isEqualTo: widget.id)
        .get();
    var userDocId = snapshotS.docs[0].id;
    var collection =
        FirebaseFirestore.instance.collection('users/$userDocId/refferedTo');
    var data = await collection.get();

    late List<Map<String, dynamic>> tempList = [];
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    print(tempList);
    setState(() {
      myConnects = tempList;
    });
  }
}
