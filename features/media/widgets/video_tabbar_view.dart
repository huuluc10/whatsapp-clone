// ignore_for_file: must_be_immutable

import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/screens/video_image_sceen.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/video_player_item.dart';
import 'package:chatapp_clone_whatsapp/models/video.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class VideoTabarView extends StatelessWidget {
  Video videos = Video();

  VideoTabarView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> link = videos.videos;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số card trên mỗi hàng
        mainAxisSpacing: 8, // Khoảng cách giữa các hàng
        crossAxisSpacing: 8, // Khoảng cách giữa các card trong cùng một hàng
      ),
      itemCount: link.length,
      itemBuilder: (context, index) => Card(
        child: InkWell(
          onTap: () {
            final messageId = const Uuid().v1();
            Navigator.pushNamed(
              context,
              VideoImageScreen.routeName,
              arguments: {
                'message': link.elementAt(index),
                'messageId': messageId,
                'messageEnum': MessageEnum.video,
              },
            );
          },
          child: VideoPlayerItem(
            videoUrl: link.elementAt(index),
          ),
        ),
      ),
    );
  }
}
