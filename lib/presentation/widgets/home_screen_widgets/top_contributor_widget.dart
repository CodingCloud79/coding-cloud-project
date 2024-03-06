import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class TopContributorWidget extends StatefulWidget {
  const TopContributorWidget({Key? key}) : super(key: key);

  @override
  State<TopContributorWidget> createState() => _TopContributorWidgetState();
}

class _TopContributorWidgetState extends State<TopContributorWidget> {
  late List<Map<String, dynamic>> topContributors = [];

  @override
  void initState() {
    super.initState();
    fetchTopContributors();
  }

  Future<void> fetchTopContributors() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
      final String userId = doc.id;
      final CollectionReference referredToCollectionRef = FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .collection('refferedTo');
      final QuerySnapshot referredToSnapshot =
          await referredToCollectionRef.get();

      if (referredToSnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        setState(() {
          topContributors.add(userSnapshot.data()! as Map<String, dynamic>);
        });

        print('$userId has ${referredToSnapshot.size} referrals');
      }
    }

    // Sort topContributors by number of referrals in descending order
    topContributors.sort((a, b) {
      // Check if 'refferedTo' field exists and is not null
      int lengthA =
          (a['refferedTo'] != null) ? (a['refferedTo'] as List).length : 0;
      int lengthB =
          (b['refferedTo'] != null) ? (b['refferedTo'] as List).length : 0;

      return lengthB.compareTo(lengthA); // Compare lengths in descending order
    });

    topContributors = topContributors.sublist(
        0, topContributors.length > 5 ? 5 : topContributors.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Top Contributors",
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.grey[400],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topContributors.length,
            itemBuilder: (context, index) {
              final user = topContributors[index];
              Future.delayed(Duration(seconds: 3));
              return Container(
                margin: EdgeInsets.all(5),
                width: 72,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Animate(
                    effects: [ScaleEffect(), RotateEffect(), FadeEffect()],
                    child: Image.network(
                      user['profileUrl'],
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
