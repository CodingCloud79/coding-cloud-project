import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopContributorWidget extends StatefulWidget {
  const TopContributorWidget({super.key});

  @override
  State<TopContributorWidget> createState() => _TopContributorWidgetState();
}

class _TopContributorWidgetState extends State<TopContributorWidget> {
  @override
  Widget build(BuildContext context) {
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
              // _buildContributor(),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildContributor() {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Icon(
        Icons.person,
        size: 48,
        color: Colors.grey,
      ),
    );
  }

}