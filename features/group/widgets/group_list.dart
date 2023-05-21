import 'package:chatapp_clone_whatsapp/common/widgets/data_null.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/chat/screens/chat_screen.dart';
import 'package:chatapp_clone_whatsapp/features/group/controller/group_controller.dart';
import 'package:chatapp_clone_whatsapp/models/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/oop.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<GroupChat>>(
      stream: ref.watch(groupControllerProvider).chatGroups(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<GroupChat>? groupList = snapshot.data;

          if (groupList == null || groupList.isEmpty) {
            return const DataNull(
              message:
                  'Bạn chưa có nhóm trò chuyện, bạn có thể tạo nhóm mới với những người khác.',
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var groupData = snapshot.data![index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ChatScreen.routeName,
                          arguments: {
                            'name': groupData.name,
                            'uid': groupData.groupId,
                            'isGroupChat': true,
                            'prifilePic': groupData.groupPic
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            groupData.name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              groupData.lastMessage,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              groupData.groupPic,
                            ),
                            radius: 30,
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(groupData.timeSent),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return const OopsWidget();
        } else {
          return const Loader();
        }
      },
    );
  }
}
