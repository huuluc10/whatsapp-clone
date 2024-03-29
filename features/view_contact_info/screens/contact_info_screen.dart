// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/controller/view_contact_info_controller.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';

class ContactInfo extends ConsumerWidget {
  static const routeName = 'contact-info';
  final String uid;
  final String name;
  final bool isOnline;

  const ContactInfo({
    super.key,
    required this.uid,
    required this.name,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? profilePic;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  FutureBuilder<UserModel?>(
                    future: ref
                        .watch(viewContactInfoControllerProvider)
                        .getInfo(uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        profilePic = snapshot.data!.profilePic;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(profilePic!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                  isOnline ? 'Đang hoạt động' : 'Ngoại tuyến'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                snapshot.data!.phoneNumber,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              showSnackBar(
                                  context: context,
                                  content: 'Tính năng chưa phát triển');
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            'Gọi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              makeCall(
                                ref: ref,
                                context: context,
                                recieverUid: uid,
                                recieverName: name,
                                recieverProfilePic: profilePic!,
                                isGroupChat: false,
                              );
                            },
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            'Gọi video',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
