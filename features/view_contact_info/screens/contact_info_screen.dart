// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatapp_clone_whatsapp/features/view_contact_info/controller/view_contact_info_controller.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';

class ContactInfo extends ConsumerWidget {
  static const routeName = 'contact-info';
  final String uid;
  final String name;

  const ContactInfo(
    this.uid,
    this.name,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    NetworkImage(snapshot.data!.profilePic),
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
                            //TODO: hiển thị thời gian
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text('isOnline'),
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
                    future: ref
                        .watch(viewContactInfoControllerProvider)
                        .getInfo(uid),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            'Audio',
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.green,
                            ),
                          ),
                          const Text(
                            'Video',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.green,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.group_add_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Create group with $name',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}