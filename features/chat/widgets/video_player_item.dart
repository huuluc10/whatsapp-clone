import 'package:cached_video_player/cached_video_player.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        // showSnackBar(context: context, content: widget.videoUrl);
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onDoubleTap: () {},
              onTap: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              child: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
