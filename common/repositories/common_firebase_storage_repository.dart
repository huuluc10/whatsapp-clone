import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
      firebaseStorage: FirebaseStorage.instance),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<Map<String, dynamic>> getFileMetadata(String ref) async {
    Map<String, dynamic> info = {};
    Reference reference = firebaseStorage.ref().child(ref);
    FullMetadata metadata = await reference.getMetadata();
    info['name'] = metadata.name;

    double size = metadata.size!.toDouble();
    String unit = 'bytes';
    if (metadata.size! < 1024) {
      // bytes
    } else if (metadata.size! < (1024 * 1024)) {
      size /= 1024;
      unit = 'KB';
    } else if (metadata.size! < (1024 * 1024 * 1024)) {
      size /= (1024 * 1024);
      unit = "MB";
    } else {
      size /= (1024 * 1024 * 1024);
      unit = "GB";
    }
    info['size'] =
        "${size.toString().substring(0, size.toString().indexOf('.') + 1)} $unit";
    return info;
  }
}
