import 'package:flutter/material.dart';

import 'image_local_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final String? placeHolderPath;
  final BoxFit? fit;

  const ImageNetworkWidget(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.placeHolderPath,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: imageUrl == null
            ? _defaultImage
            : placeHolderPath == null
                ? Image.network(
                    imageUrl!,
                    fit: fit ?? BoxFit.fill,
                    width: width,
                    height: height,
                    errorBuilder: (context, exception, stackTrace) {
                      return SizedBox(width: width,height: height,);
                    },
                  )
                : Image.network(
                    imageUrl!,
                    fit: fit ?? BoxFit.fill,
                    width: width,
                    height: height,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return _defaultImage;
                    },
                    errorBuilder: (context, exception, stackTrace) {
                      return _defaultImage;
                    },
                  ),
      ),
    );
  }

  Widget get _defaultImage {
    return ImageLocalWidget(
        imagePath: placeHolderPath!, width: width, height: height);
  }
}
