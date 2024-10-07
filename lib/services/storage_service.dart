import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService() {}

  Future<String?> uploadUserProfilePic({
    required File file,
    required String uid,
  }) async {
    Reference fileReference = _firebaseStorage
        .ref('users/profilePics')
        .child('$uid${path.extension(file.path)}');
    UploadTask uploadTask = fileReference.putFile(file);
    return uploadTask.then((p) {
      if (p.state == TaskState.success) {
        return fileReference.getDownloadURL();
      }
      return null;
    });
  }
  Future<String?> uploadChatImage({
    required File file,
    required String chatID,
  }) async {
    Reference fileReference = _firebaseStorage
        .ref('chats/$chatID')
        .child('${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}');
    UploadTask uploadTask = fileReference.putFile(file);
    return uploadTask.then((p) {
      if (p.state == TaskState.success) {
        return fileReference.getDownloadURL();
      }
      return null;
    });
  }
}
