// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;

  Message({
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "text": text,
      "type": type.type,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "messageId": messageId,
      "isSeen": isSeen,
      "repliedMessage": repliedMessage,
      "repliedTo": repliedTo,
      "repliedMessageType": repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"],
      recieverId: json["recieverId"],
      text: json["text"],
      type: (json["type"] as String).toEnum(),
      timeSent: DateTime.parse(json["timeSent"]),
      messageId: json["messageId"],
      isSeen: json["isSeen"].toLowerCase() == 'true',
      repliedMessage: json["repliedMessage"],
      repliedTo: json["repliedTo"],
      repliedMessageType: (json["repliedMessageType"] as String).toEnum(),
    );
  }
//
}
