import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double size;

  const ImageWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.0), // Update the border color and opacity
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2), // Clip the image as a circle
        child: Image.asset(
          'assets/new_profile_image.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
