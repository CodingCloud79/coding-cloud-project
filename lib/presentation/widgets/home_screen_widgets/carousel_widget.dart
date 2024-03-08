// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class CarouselWidget extends StatefulWidget {
//   const CarouselWidget({super.key});

//   @override
//   State<CarouselWidget> createState() => _CarouselWidgetState();
// }

// class _CarouselWidgetState extends State<CarouselWidget> {
//   List<String> carouselList = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     getCarouselList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Animate(
//       effects: [FadeEffect()],
//       child: Container(
//         margin: const EdgeInsets.all(5),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             autoPlay: true,
//             aspectRatio: 18 / 9,
//             viewportFraction: 1,
//           ),
//           items: carouselList
//               .map(
//                 (item) => ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: CachedNetworkImage(
//                     imageUrl: item,
//                     placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }

//   Future<void> getCarouselList() async {
//     List<String> imageUrls = [];

//     // Get reference to the specific path in Firebase Storage
//     Reference storageRef = FirebaseStorage.instance.ref().child('sliderImages');

//     try {
//       // List all items (images) under the specified path
//       final result = await storageRef.listAll();

//       // Iterate through the items and get download URLs
//       await Future.forEach(result.items, (Reference ref) async {
//         String downloadUrl = await ref.getDownloadURL();
//         imageUrls.add(downloadUrl);
//       });
//     } catch (e) {
//       print('Error fetching images: $e');
//     }
//     setState(() {
//       carouselList = imageUrls;
//     });
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<String> carouselList = [];
  bool isLoading = true; // Flag to track if images are still loading

  @override
  void initState() {
    super.initState();
    getCarouselList();
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect()],
      child: Container(
        margin: const EdgeInsets.all(5),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while images are loading
            : CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 18 / 9,
                  viewportFraction: 1,
                ),
                items: carouselList
                    .map(
                      (item) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: item,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  Future<void> getCarouselList() async {
    List<String> imageUrls = [];

    // Get reference to the specific path in Firebase Storage
    Reference storageRef = FirebaseStorage.instance.ref().child('sliderImages');

    try {
      // List all items (images) under the specified path
      final result = await storageRef.listAll();

      // Iterate through the items and get download URLs
      await Future.forEach(result.items, (Reference ref) async {
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      });
    } catch (e) {
      print('Error fetching images: $e');
      // Handle error while fetching images
    }

    // Update state with fetched image URLs
    setState(() {
      carouselList = imageUrls;
      isLoading = false; // Images are loaded, so set isLoading to false
    });
  }
}

