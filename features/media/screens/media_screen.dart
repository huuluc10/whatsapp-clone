// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/features/media/widgets/audio_tabbar_view.dart';
import 'package:chatapp_clone_whatsapp/features/media/widgets/document_tabbar_view.dart';
import 'package:chatapp_clone_whatsapp/features/media/widgets/image_tabbar_view.dart';
import 'package:chatapp_clone_whatsapp/features/media/widgets/video_tabbar_view.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({
    Key? key,
    required this.name,
  }) : super(key: key);
  static const String routeName = '/media_screen';
  final String name;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          bottom: const TabBar(
            indicatorColor: tabColor,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: 'Hình ảnh',
              ),
              Tab(
                text: 'Videos',
              ),
              Tab(
                text: 'Âm thanh',
              ),
              Tab(
                text: 'Tập tin',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ImageTabarView(),
            VideoTabarView(),
            AudioTabarView(),
            DocumentTabarView(),
          ],
        ),
      ),
    );
  }
}
