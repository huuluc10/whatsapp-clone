import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/screens/video_image_sceen.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/audio_play_item.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/video_player_item.dart';
import 'package:flutter/material.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final String messageId;

  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
    required this.messageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return AudioPlayerItem(message: message);
              })
            : type == MessageEnum.video
                ? VideoPlayerItem(videoUrl: message)
                : type == MessageEnum.gif
                    ? CachedNetworkImage(imageUrl: message)
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            VideoImageScreen.routeName,
                            arguments: {
                              'message': message,
                              'messageId': messageId,
                            },
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: message,
                        ),
                      );
  }
}
