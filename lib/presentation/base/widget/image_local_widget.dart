import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageLocalWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ImageLocalWidget(
      {super.key,
      required this.imagePath,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    if (imagePath.endsWith(".svg")) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
      );
    }
  }
}
