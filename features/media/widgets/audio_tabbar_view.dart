// ignore_for_file: must_be_immutable

import 'package:chatapp_clone_whatsapp/features/chat/widgets/audio_play_item.dart';
import 'package:chatapp_clone_whatsapp/models/audio.dart';
import 'package:flutter/material.dart';

class AudioTabarView extends StatelessWidget {
  Audio audios = Audio();
  final ScrollController audioController = ScrollController();

  AudioTabarView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> link = audios.audio;
    return ListView.builder(
      controller: audioController,
      itemCount: link.length,
      itemBuilder: (context, index) => SizedBox(
        width: (MediaQuery.of(context).size.width - 30) / 2,
        child: Card(
          child: InkWell(
            child: AudioPlayerItem(
              message: link.elementAt(index),
            ),
          ),
        ),
      ),
    );
  }
}
