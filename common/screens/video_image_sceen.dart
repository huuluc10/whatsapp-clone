// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';

class VideoImageScreen extends StatefulWidget {
  const VideoImageScreen({
    Key? key,
    required this.message,
    required this.messageId,
    required this.messageEnum,
  }) : super(key: key);
  static const String routeName = '/video-image-screen';
  final String message;
  final String messageId;
  final MessageEnum messageEnum;

  @override
  State<VideoImageScreen> createState() => _VideoImageScreenState();
}

class _VideoImageScreenState extends State<VideoImageScreen> {
  bool isHide = false;

  Future<File?> downloadFile(String url) async {
    showSnackBar(context: context, content: "Đang tải");
    File? file = await downloadFileFromServer(
      context,
      widget.message,
      widget.messageEnum == MessageEnum.image
          ? '${widget.messageId}.jpg'
          : '${widget.messageId}.mp4',
    );

    return file;
  }

  late CachedVideoPlayerController? videoPlayerController;
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
    if (widget.messageEnum == MessageEnum.video) {
      videoPlayerController =
          CachedVideoPlayerController.network(widget.message)
            ..initialize().then(
              (value) {
                // showSnackBar(context: context, content: widget.videoUrl);
                videoPlayerController!.setVolume(1);
                videoPlayerController!.setLooping(false);

                // videoPlayerController!.se
              },
            );
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.messageEnum == MessageEnum.video) {
      videoPlayerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: widget.messageEnum == MessageEnum.image
          ? InkWell(
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
                                  File? file =
                                      await downloadFile(widget.message);
                                  if (file != null) {
                                    showSnackBar(
                                        context: context,
                                        content: 'Tải hình ảnh thành công');
                                  } else {
                                    showSnackBar(
                                        context: context,
                                        content: 'Tải thất bại');
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.save_alt_sharp),
                                      Text(
                                        'Lưu',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                ),
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isHide = !isHide;
                });
              },
              child: Stack(
                children: [
                  CachedVideoPlayer(videoPlayerController!),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onDoubleTap: () {},
                      onTap: () {
                        if (isPlay) {
                          videoPlayerController!.pause();
                        } else {
                          videoPlayerController!.play();
                        }
                        setState(() {
                          isPlay = !isPlay;
                        });
                      },
                      child: Icon(
                        isPlay ? Icons.pause_circle : Icons.play_circle,
                        size: 80,
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
                                      content: 'Tải video thành công');
                                } else {
                                  showSnackBar(
                                      context: context,
                                      content: 'Tải thất bại');
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Lưu',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
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
                                  'Video',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
