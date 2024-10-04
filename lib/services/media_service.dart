import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService{
  MediaService(){}

  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print("Error in pickImage: $e");
    }
    return null;
  }
}