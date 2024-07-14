import 'dart:io';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatefulWidget {
  final File file;

  const ImagePreviewWidget({Key? key, required this.file}) : super(key: key);

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  double _scale = 1.0;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (isTapped == false) {
          setState(() {
            _scale = 4.0;
            isTapped = true;
          });
        } else {
          setState(() {
            _scale = 1.0;
            isTapped = false;
          });
        }
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = details.scale.clamp(1.0, 4.0);
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: SizedBox(
          height: getHeight(context) * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              widget.file,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
