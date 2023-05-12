import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:flutter/material.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
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
              padding: const EdgeInsets.only(
                  left: 10, right: 30, top: 5, bottom: 20),
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 5,
              child: Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 13, color: Colors.white60),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.done_all,
                    size: 20,
                    color: Colors.white60,
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
