import 'dart:io';

import 'package:chatapp_clone_whatsapp/models/group.dart';
import 'package:chatapp_clone_whatsapp/models/message.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/features/group/repository/group_repository.dart';

final groupControllerProvider = Provider(
  (ref) {
    final groupRepository = ref.read(groupRepositoryProvider);
    return GroupController(groupRepository: groupRepository, ref: ref);
  },
);

class GroupController {
  final GroupRepository groupRepository;
  final ProviderRef ref;

  GroupController({
    required this.groupRepository,
    required this.ref,
  });

  Stream<List<GroupChat>> chatGroups() {
    return groupRepository.getChatGroups();
  }

  void createGroup(
    BuildContext context,
    String nameGroup,
    File groupPic,
    List<Contact> contacts,
  ) {
    groupRepository.createGroup(context, nameGroup, groupPic, contacts);
  }

  Stream<List<Message>> chatGroupStream(String groupId) {
    return groupRepository.getGroupChatStream(groupId);
  }

  Future<List<UserModel>> getListUserInGroup(String groupId) async {
    return groupRepository.getListUserInGroup(groupId);
  }

  Future<GroupChat?> getGroupData(String groupId) async {
    return groupRepository.getGroupData(groupId);
  }

  void changeProfileImageGroup(
    BuildContext context,
    String groupId,
    File profilePic,
  ) async {
    return groupRepository.changeImageProfileGroup(
      groupId: groupId,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }
}
