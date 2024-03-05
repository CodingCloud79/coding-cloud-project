import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<String> list = ['Item 1', 'Item 2', 'Item 3']; //
  @override
  Widget build(BuildContext context) {
    return  
     Animate(
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
}