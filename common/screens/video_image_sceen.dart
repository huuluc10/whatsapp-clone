// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class VideoImageScreen extends StatefulWidget {
  const VideoImageScreen({
    Key? key,
    required this.message,
    required this.messageId,
  }) : super(key: key);
  static const String routeName = '/video-image-screen';
  final String message;
  final String messageId;

  @override
  State<VideoImageScreen> createState() => _VideoImageScreenState();
}

class _VideoImageScreenState extends State<VideoImageScreen> {
  bool isHide = false;

  Future<File?> downloadFile(String url) async {
    File? file;
    var response = await http.get(Uri.parse(url));
    var filePath = '/storage/emulated/0/Download/${widget.messageId}.jpg';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: InkWell(
        onTap: () {
          setState(() {
            isHide = !isHide;
          });
        },
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              color: Colors.black,
              width: size.width,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.message,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            isHide
                ? Positioned(child: Container())
                : Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(50),
                            Colors.black.withAlpha(30),
                            Colors.black.withAlpha(10),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          //tải hỉnh ảnh về thư mục download
                          File? file = await downloadFile(widget.message);
                          if (file != null) {
                            showSnackBar(
                                context: context,
                                content: 'Tải hình ảnh thành công');
                          } else {
                            showSnackBar(
                                context: context, content: 'Tải thất bại');
                          }
                        },
                        child: const Text(
                          'Lưu',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
            isHide
                ? Positioned(child: Container())
                : Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withAlpha(50),
                            Colors.black.withAlpha(30),
                            Colors.black.withAlpha(10),
                            Colors.transparent,
                          ])),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const Text(
                            'Hình ảnh',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        )),
      ),
    );
  }
}
