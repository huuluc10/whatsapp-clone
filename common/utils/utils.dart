import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<String?> showConfirmDialog(
    BuildContext context, String disMessage) async {
  AlertDialog dialog = AlertDialog(
    title: const Text('Xác nhận'),
    content: Text(disMessage),
    actions: [
      ElevatedButton(
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop("cancel"),
          child: const Text("Hủy")),
      ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
          child: const Text("Ok")),
    ],
  );
  String? res = await showDialog<String?>(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );
  return res;
}

Future<File?> pickImageFromGalary(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'UjQWPmv1BYugYfR4ftbAVy6R7ltJvfxs',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}
