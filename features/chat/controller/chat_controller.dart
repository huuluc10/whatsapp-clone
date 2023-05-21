import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/models/chat_contact.dart';
import 'package:chatapp_clone_whatsapp/models/message.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  Future<Map<String, dynamic>> getFileMetadata({
    required BuildContext context,
    required String recieverUserId,
    required MessageEnum messageEnum,
    required String messageId,
  }) async {
    UserModel? userSender;
    await ref.read(userDataAuthProvider).whenData((value) {
      userSender = value!;
    });
    return chatRepository.getFileMetadata(
        context: context,
        recieverUserId: recieverUserId,
        senderUserData: userSender,
        ref: ref,
        messageEnum: messageEnum,
        messageId: messageId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
            isGroupChat: isGroupChat,
          ),
        );
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value!,
            messageEnum: messageEnum,
            ref: ref,
            isGroupChat: isGroupChat,
          ),
        );
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
    bool isGroupChat,
  ) {
    //https://giphy.com/gifs/mumbaiindians-mumbai-indians-ipl-2023-arjun-tendulkar-xtLtPJDa3HCaRG4olK
    //https://i.giphy.com/media/xtLtPJDa3HCaRG4olK/200.gif
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String gifNewUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendGIFMessage(
            context: context,
            gifUrl: gifNewUrl,
            recieverUserId: recieverUserId,
            senderUser: value!,
            isGroupChat: isGroupChat));
  }

  void setChatStatusSeen(
      BuildContext context, String uid, String messageId) async {
    chatRepository.setChatStatusSeen(context, uid, messageId);
  }
}
