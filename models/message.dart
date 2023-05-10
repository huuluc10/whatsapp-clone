import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toJson() {
    return {
      "senderId": this.senderId,
      "recieverId": this.recieverId,
      "text": this.text,
      "type": this.type,
      "timeSent": this.timeSent.toIso8601String(),
      "messageId": this.messageId,
      "isSeen": this.isSeen,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"],
      recieverId: json["recieverId"],
      text: json["text"],
      type: json["type"],
      timeSent: DateTime.parse(json["timeSent"]),
      messageId: json["messageId"],
      isSeen: json["isSeen"].toLowerCase() == 'true',
    );
  }
//
}
