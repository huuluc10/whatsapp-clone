// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_clone_whatsapp/features/media/models/image.dart';
import 'package:flutter/material.dart';

class ImageTabarView extends StatelessWidget {
  Img images = Img();
  ImageTabarView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> link = images.link;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số card trên mỗi hàng
        mainAxisSpacing: 8, // Khoảng cách giữa các hàng
        crossAxisSpacing: 8, // Khoảng cách giữa các card trong cùng một hàng
      ),
      itemCount: link.length,
      itemBuilder: (context, index) => Card(
        child: CachedNetworkImage(
          imageUrl: link.elementAt(index),
        ),
      ),
    );
  }
}
