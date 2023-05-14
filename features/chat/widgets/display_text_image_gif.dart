// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/screens/video_image_sceen.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/audio_play_item.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/document_item.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/video_player_item.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final String messageId;
  final String recieverUserId;

  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
    required this.messageId,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MessageEnum.text:
        return Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      case MessageEnum.image:
        return InkWell(
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
      case MessageEnum.audio:
        return StatefulBuilder(builder: (context, setState) {
          return AudioPlayerItem(message: message);
        });
      case MessageEnum.video:
        return VideoPlayerItem(videoUrl: message);
      case MessageEnum.doc:
        return DocumentItem(
          mesage: message,
          messageId: messageId,
          recieverUserId: recieverUserId,
        );
      case MessageEnum.gif:
        return CachedNetworkImage(imageUrl: message);
    }
  }
}
