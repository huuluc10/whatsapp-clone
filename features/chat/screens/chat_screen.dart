import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/chat_list.dart';
import 'package:flutter/material.dart';

import '../../../info.dart';
import '../widgets/bottom_chat_field.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(info[0]['name'].toString()),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          BottomChatField(
            recieverUserId: uid,
          )
        ],
      ),
    );
  }
}
