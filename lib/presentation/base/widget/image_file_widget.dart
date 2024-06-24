import 'dart:io';

import 'package:flutter/material.dart';

class ImageFileWidget extends StatelessWidget {
  final String imageURL;
  final double width;
  final double height;

  const ImageFileWidget(
      {super.key,
      required this.imageURL,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(0.1),
        width: width,
        height: height,
        child: ClipOval(
          child: Image.file(
            width: 70,
            height: 70,
            File(imageURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
