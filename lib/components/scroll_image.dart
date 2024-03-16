import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slash/views/screen_image.dart';

class ScrollImage extends StatelessWidget {
  final PageController pageController;
  final int index;
  final String image;

  const ScrollImage({
    Key? key,
    required this.pageController,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FullScreenImage(
            imageUrl: image,
          );
        }));
      },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 0.0;
          if (pageController.position.haveDimensions) {
            value = index.toDouble() - (pageController.page ?? 0);
            value *= 0.1;
          }
          return Transform.rotate(
            angle: pi * value,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Handle error by showing a placeholder or error image
                  return Image.asset(
                    'assets/error_image.png', // Path to your error image
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
