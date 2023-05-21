// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chatapp_clone_whatsapp/common/enums/source_file_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/features/group/controller/group_controller.dart';
import 'package:chatapp_clone_whatsapp/models/group.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupInfoScreen extends ConsumerStatefulWidget {
  const GroupInfoScreen({
    super.key,
    required this.uid,
    required this.name,
  });
  static const routeName = '/group-info';
  final String uid;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GroupInfoScreenState();
}

class _GroupInfoScreenState extends ConsumerState<GroupInfoScreen> {
  @override
  Widget build(BuildContext context) {
    File? image;
    void selectImage() async {
      image = await pickImage(context, SourceFile.gallary);
      if (image != null) {
        ref.read(groupControllerProvider).changeProfileImageGroup(
              context,
              widget.uid,
              image!,
            );
      }
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                FutureBuilder(
                  future: ref
                      .read(groupControllerProvider)
                      .getGroupData(widget.uid),
                  builder: (context, snapshot) {
                    String profilePic = '';
                    if (snapshot.hasError) {
                      return ErrorScreen(error: snapshot.error.toString());
                    }
                    if (snapshot.hasData) {
                      GroupChat group = snapshot.data!;
                      profilePic = group.groupPic;
                    }
                    return Stack(
                      children: [
                        profilePic != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(profilePic),
                                radius: 64,
                              )
                            : image == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/group.jpg'),
                                    radius: 64,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(image!),
                                    radius: 64,
                                  ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            width: 50,
                            height: 40,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Danh sách thành viên',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: ref
                  .read(groupControllerProvider)
                  .getListUserInGroup(widget.uid),
              builder: (context, snapshot) {
                List<UserModel> list = [];

                if (snapshot.hasError) {
                  return ErrorScreen(error: snapshot.error.toString());
                } else {
                  if (snapshot.hasData) {
                    list = snapshot.data!;
                  }
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: 350,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(list[index].profilePic),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index].name),
                                  Text(list[index].phoneNumber),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
