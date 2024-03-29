// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/features/group/controller/group_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/chat/controller/chat_controller.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/my_message_card.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/sender_message_card.dart';
import 'package:chatapp_clone_whatsapp/models/audio.dart';
import 'package:chatapp_clone_whatsapp/models/document.dart';
import 'package:chatapp_clone_whatsapp/models/image.dart';
import 'package:chatapp_clone_whatsapp/models/message.dart';
import 'package:chatapp_clone_whatsapp/models/video.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;

  const ChatList({
    super.key,
    required this.recieverUserId,
    required this.isGroupChat,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Audio audios = Audio();
    audios.removeList();
    Document documents = Document();
    documents.removeList();
    Img images = Img();
    images.removeList();
    Video video = Video();
    video.removeList();
    return StreamBuilder<List<Message>>(
      stream: !widget.isGroupChat
          ? ref.read(chatControllerProvider).chatStream(widget.recieverUserId)
          : ref
              .read(groupControllerProvider)
              .chatGroupStream(widget.recieverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageController.jumpTo(messageController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final messageData = snapshot.data![index];
            var timeSent = DateFormat.Hm().format(messageData.timeSent);
            if (!messageData.isSeen &&
                messageData.recieverId ==
                    FirebaseAuth.instance.currentUser!.uid) {
              ref.read(chatControllerProvider).setChatStatusSeen(
                  context, widget.recieverUserId, messageData.messageId);
            }
            if (messageData.senderId ==
                FirebaseAuth.instance.currentUser!.uid) {
              return MyMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                messageId: messageData.messageId,
                recieverUserId: widget.recieverUserId,
                isSeen: messageData.isSeen,
              );
            }
            return SenderMessageCard(
              message: messageData.text,
              date: timeSent,
              type: messageData.type,
              messageId: messageData.messageId,
              recieverUserId: widget.recieverUserId,
            );
          },
        );
      },
    );
  }
}
