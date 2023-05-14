// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/enums/source_file_enum.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

Future<File?> pickImage(BuildContext context, SourceFile source) async {
  File? image;
  try {
    final pickedImage;
    if (source == SourceFile.gallary) {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    }

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

Future<File?> pickVideo(BuildContext context, SourceFile source) async {
  File? video;
  try {
    final pickedVideo;
    if (source == SourceFile.gallary) {
      pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    } else {
      pickedVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
    }

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

Future<File?> pickAudio(BuildContext context) async {
  File? audio;
  try {
    final pickedAudio = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (pickedAudio != null) {
      final platformFile = pickedAudio.files.first;
      audio = File(platformFile.path!);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return audio;
}

Future<File?> pickDocument(BuildContext context) async {
  File? file;
  try {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      'doc',
      'docx',
      'xml',
      'rar',
      'zip',
      'pdf',
      'txt',
      'sql',
      'c',
      'cpp',
      'xsl',
      'xlsx',
      'pptx',
      'dart',
      'apk',
      'html',
      'js',
      'css',
      'java'
    ]);

    if (pickedFile != null) {
      final platformFile = pickedFile.files.first;
      file = File(platformFile.path!);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return file;
}

Future<File?> downloadFileFromServer(
    BuildContext context, String url, String fileName) async {
  File? file;
  var http;
  var response = await http.get(Uri.parse(url));
  var filePath = '/storage/emulated/0/Download/$fileName';
  try {
    file = await File(filePath).writeAsBytes(response.bodyBytes);
  } catch (e) {
    showSnackBar(
      context: context,
      content: e.toString(),
    );
  }
  return file;
}
