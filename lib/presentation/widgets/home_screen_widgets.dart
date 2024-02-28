import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTabWidget extends StatefulWidget {
  @override
  _HomeTabWidgetState createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  late final String? uuid;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCarousel(),
          _buildActionRow(),
          _buildQuizSection(),
          _buildContributorSection(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    List<String> list = ['Item 1', 'Item 2', 'Item 3']; // Your list of items
    return Animate(
      effects: [FadeEffect()],
      child: Container(
        margin: const EdgeInsets.all(5),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 18 / 9,
            viewportFraction: 1,
          ),
          items: list
              .map(
                (item) => Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(item),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Share.share("Refer to your Friend $uuid\n", subject: "Referral");
            },
            child: _buildCard("Refer Friends"),
          ),
          GestureDetector(
            onTap: () {},
            child: _buildCard("My Earning"),
          ),
          GestureDetector(
            onTap: () {
              // Handle navigation to My Course
            },
            child: _buildCard("My Course"),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title) {
    return Animate(
      effects: [ScaleEffect(duration: Duration(milliseconds: 500))],
      child: Container(
        height: 80,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  Widget _buildQuizSection() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Quiz",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributorSection() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Contributor",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _buildContributor(),
              _buildContributor(),
              _buildContributor(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContributor() {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Icon(
        Icons.person,
        size: 32,
        color: Colors.grey,
      ),
    );
  }

  Future<void> getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uuid = _prefs.getString('uuid');
    });
  }
}
