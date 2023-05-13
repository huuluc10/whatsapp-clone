import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/video_player_item.dart';
import 'package:chatapp_clone_whatsapp/models/message.dart';
import 'package:flutter/cupertino.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF(
      {Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(message);
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: '$message')
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
