// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/screens/video_image_sceen.dart';
import 'package:chatapp_clone_whatsapp/models/image.dart';
import 'package:chatapp_clone_whatsapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ImageTabarView extends StatelessWidget {
  Img images = Img();
  ImageTabarView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> link = images.link;
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
                'messageEnum': MessageEnum.image,
              },
            );
          },
          child: CachedNetworkImage(
            imageUrl: link.elementAt(index),
          ),
        ),
      ),
    );
  }
}
