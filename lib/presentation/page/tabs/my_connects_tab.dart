import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_application_1/presentation/page/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: ListView.builder(
                  itemCount: myConnects.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Animate(
                        effects: [ScaleEffect()],
                        child: Column(
                          children: [
                            Text(myConnects[index]['name']),
                            Text(myConnects[index]['uuid']),
                          ],
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
    var collection = FirebaseFirestore.instance
        .collection('users/hx1Pt0jmmXeLmFhwpDGc/refferedTo');
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
