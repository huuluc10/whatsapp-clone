// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
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
      length: 3,
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
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Text('Hình ảnh sẽ hiển thị ở đây'),
            Text('Video sẽ hiển thị ở đây'),
            Text('Âm thanh sẽ hiển thị ở đây'),
          ],
        ),
      ),
    );
  }
}
