import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/chat_list.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/screens/contact_info_screen.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/bottom_chat_field.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;

  const ChatScreen({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                children: [
                  Text(name),
                  // Text(
                  //   snapshot.data!.isOnline ? 'online' : 'offline',
                  //   style:
                  //       const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  // ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          PopupMenuButton<String>(
            color: appBarColor,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            onSelected: (value) {
              if (value == 'contact-info') {
                Navigator.pushNamed(
                  context,
                  ContactInfo.routeName,
                  arguments: {
                    'uid': uid,
                    'name': name,
                  },
                );
              } else if (value == 'images') {
                //TODO: chuyển hướng sang gridview hình ảnh
              } else {
                //TODO: xóa cuộc trò chuyện
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(
                value: "contact-info",
                child: SizedBox(
                  width: 100,
                  child: Text('View contact'),
                ),
              ),
              const PopupMenuItem(
                value: 'images',
                child: SizedBox(
                  width: 100,
                  child: Text('Images'),
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: SizedBox(
                  width: 100,
                  child: Text('Clear chat'),
                ),
              ),
            ],
          )
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
