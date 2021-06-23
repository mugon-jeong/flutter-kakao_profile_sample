import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirestorageRepository {
  firebase_storage.UploadTask uploadImageFile(
      String uid, String filename, io.File file) {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/$uid')
        .child('/$filename.jpg');

    return ref.putFile(io.File(file.path));
  }
}
