// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/display_text_image_gif.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final String messageId;
  final String recieverUserId;
  final bool isSeen;
  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.messageId,
    required this.recieverUserId,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: 110,
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(children: [
            Padding(
              padding: type == MessageEnum.text
                  ? const EdgeInsets.only(
                      left: 10,
                      right: 30,
                      top: 5,
                      bottom: 20,
                    )
                  : const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 5,
                      bottom: 25,
                    ),
              child: DisplayTextImageGIF(
                message: message,
                type: type,
                messageId: messageId,
                recieverUserId: recieverUserId,
              ),
            ),
            Positioned(
              bottom: 1,
              right: 5,
              child: Row(
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    isSeen ? Icons.done_all : Icons.done,
                    size: 20,
                    color: isSeen ? Colors.blue : Colors.white60,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
