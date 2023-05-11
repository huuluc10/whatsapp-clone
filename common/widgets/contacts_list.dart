import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/chat_list.dart';
import 'package:chatapp_clone_whatsapp/models/chat_contact.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ChatContact>>(
                    // stream: ,
                    builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: info.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text(
                            info[index]['name'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              info[index]['message'].toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              info[index]['profilePic'].toString(),
                            ),
                          ),
                          trailing: Text(
                            info[index]['time'].toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        });
  }
}
