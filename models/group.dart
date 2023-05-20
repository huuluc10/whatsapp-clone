import 'dart:convert';

class GroupChat {
  final String senderId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final List<String> listMemberId;
  final DateTime timeSent;

  GroupChat({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.listMemberId,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'name': name,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupPic': groupPic,
      'listMemberId': listMemberId,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory GroupChat.fromMap(Map<String, dynamic> map) {
    return GroupChat(
      senderId: map['senderId'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      lastMessage: map['lastMessage'] as String,
      groupPic: map['groupPic'] as String,
      listMemberId: List<String>.from(map['listMemberId']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupChat.fromJson(String source) =>
      GroupChat.fromMap(json.decode(source) as Map<String, dynamic>);
}
