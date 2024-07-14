import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File> pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image;
    }
    return File("");
  }

  Future<File> pickMedia() async {
    final pickedFile = await ImagePicker().pickMedia();
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image;
    }
    return File("");
  }
}
