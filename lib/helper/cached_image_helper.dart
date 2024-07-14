import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/images_path.dart';

class CachedImageHelper extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const CachedImageHelper(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: height,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (context, url) => Center(
        child: SizedBox(
            height: 30, width: 30, child: Image.asset(AppImages.appIcon)),
      ),
    ));
  }
}
