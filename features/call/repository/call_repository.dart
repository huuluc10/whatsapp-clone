import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/call/screens/call_screen.dart';
import 'package:chatapp_clone_whatsapp/models/call.dart';
import 'package:chatapp_clone_whatsapp/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callRepositoryProvider = Provider(
  (ref) => CallRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class CallRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CallRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<DocumentSnapshot> get callSream =>
      firestore.collection('call').doc(auth.currentUser!.uid).snapshots();

  void makeCall(
    Call senderCallData,
    BuildContext context,
    Call recieverCallData,
  ) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await firestore
          .collection('call')
          .doc(senderCallData.recieverId)
          .set(recieverCallData.toMap());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(
              channelId: senderCallData.callId,
              call: senderCallData,
              isGroupChat: false,
              name: senderCallData.callerName,
            ),
          ));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void makeGroupCall(
    Call senderCallData,
    BuildContext context,
    Call recieverCallData,
  ) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firestore
          .collection('groups')
          .doc(senderCallData.recieverId)
          .get();
      GroupChat group = GroupChat.fromMap(groupSnapshot.data()!);
      for (var id in group.listMemberId) {
        await firestore
            .collection('call')
            .doc(id)
            .set(recieverCallData.toMap());
      }

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(
              channelId: senderCallData.callId,
              call: senderCallData,
              isGroupChat: false,
              name: senderCallData.callerName,
            ),
          ));
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endCall(
    String callerId,
    BuildContext context,
    String recieverId,
  ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(recieverId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endGroupCall(
    String callerId,
    BuildContext context,
    String recieverId,
  ) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      var groupSnapshot =
          await firestore.collection('groups').doc(recieverId).get();
      GroupChat group = GroupChat.fromMap(groupSnapshot.data()!);
      for (var id in group.listMemberId) {
        await firestore.collection('call').doc(id).delete();
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
