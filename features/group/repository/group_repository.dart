import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/repositories/common_firebase_storage_repository.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/chat/screens/chat_screen.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/controller/view_contact_info_controller.dart';
import 'package:chatapp_clone_whatsapp/models/group.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final groupRepositoryProvider = Provider(
  (ref) => GroupRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;

  GroupRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  Stream<List<GroupChat>> getChatGroups() {
    return firestore.collection('groups').snapshots().asyncMap((event) async {
      try {
        List<GroupChat> groups = [];
        for (var document in event.docs) {
          // print(document.data().keys[])
          var group = GroupChat.fromMap(document.data());
          if (group.listMemberId.contains(auth.currentUser!.uid)) {
            groups.add(group);
          }
        }
        return groups;
      } catch (e) {
        return []; // Trả về danh sách rỗng trong trường hợp lỗi
      }
    });
  }

  List<String> removeDuplicates(List<String> uids) {
    Set<String> uniqueUids = Set<String>.from(uids);
    return uniqueUids.toList();
  }

  void createGroup(
    BuildContext context,
    String nameGroup,
    File groupPic,
    List<Contact> contacts,
  ) async {
    List<String> uids = [];
    for (int i = 0; i < contacts.length; i++) {
      var user = await firestore
          .collection('users')
          .where(
            'phoneNumber',
            isEqualTo: contacts[i]
                .phones[0]
                .number
                .replaceAll(' ', '')
                .replaceFirst('0', '+84'),
          )
          .get();
      if (user.docs.isNotEmpty && user.docs[0].exists) {
        uids.add(user.docs[0].data()['uid']);
      }
    }
    uids.add(auth.currentUser!.uid);
    uids = removeDuplicates(uids);
    if (uids.length > 1) {
      var groupId = const Uuid().v1();
      String groupPicture = await ref
          .watch(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase('groups/$groupId', groupPic);

      GroupChat groupChat = GroupChat(
        senderId: auth.currentUser!.uid,
        name: nameGroup,
        groupId: groupId,
        lastMessage: '',
        groupPic: groupPicture,
        listMemberId: uids,
        timeSent: DateTime.now(),
      );
      await firestore.collection('groups').doc(groupId).set(groupChat.toMap());
    } else if (uids.length == 1) {
      UserModel? user =
          await ref.watch(viewContactInfoControllerProvider).getInfo(uids[0]);
      Navigator.pushNamed(
        context,
        ChatScreen.routeName,
        arguments: {
          'name': user!.name,
          'uid': user.uid,
        },
      );
    }
    try {} catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
