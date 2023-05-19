// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerItem extends StatefulWidget {
  const AudioPlayerItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  State<AudioPlayerItem> createState() => _AudioPlayerItemState();
}

class _AudioPlayerItemState extends State<AudioPlayerItem> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      switch (event) {
        case PlayerState.playing:
          setState(() {
            isPlaying = true;
          });
          break;
        case PlayerState.paused:
          setState(() {
            isPlaying = false;
          });
          break;
        case PlayerState.stopped:
          setState(() {
            isPlaying = false;
          });
          break;
        case PlayerState.completed:
          setState(() {
            isPlaying = false;
          });
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 80,
      ),
      child: SizedBox(
        width: 150,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(64),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.headphones,
                  size: 30,
                ),
              ),
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(UrlSource(widget.message));
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
