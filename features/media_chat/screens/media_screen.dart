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
                text: 'Images',
              ),
              Tab(
                text: 'Videos',
              ),
              Tab(
                text: 'Audio',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Text('Images will show hear'),
            Text('Videos will show hear'),
            Text('Audio will show hear'),
          ],
        ),
      ),
    );
  }
}
