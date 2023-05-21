// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/call/repository/call_repository.dart';
import 'package:chatapp_clone_whatsapp/models/call.dart';
import 'package:uuid/uuid.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    ref: ref,
    auth: FirebaseAuth.instance,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;
  final FirebaseAuth auth;

  CallController({
    required this.callRepository,
    required this.ref,
    required this.auth,
  });

  void makeCall(
    String recieverName,
    BuildContext context,
    String recieverUid,
    String recieverProfilePic,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData(
      (value) {
        String callId = const Uuid().v1();

        Call senderCallData = Call(
          callerId: auth.currentUser!.uid,
          callerName: value!.name,
          callerPic: value.profilePic,
          recieverId: recieverUid,
          recieverName: recieverName,
          recieverPic: recieverProfilePic,
          callId: callId,
          hasDialeld: true,
        );

        Call recieverCallData = Call(
          callerId: auth.currentUser!.uid,
          callerName: value.name,
          callerPic: value.profilePic,
          recieverId: recieverUid,
          recieverName: recieverName,
          recieverPic: recieverProfilePic,
          callId: callId,
          hasDialeld: false,
        );

        if (isGroupChat) {
          callRepository.makeGroupCall(
            senderCallData,
            context,
            recieverCallData,
          );
        } else {
          callRepository.makeCall(
            senderCallData,
            context,
            recieverCallData,
          );
        }
      },
    );
  }

  Stream<DocumentSnapshot> get callStream => callRepository.callSream;

  void endCall(String callerId, BuildContext context, String recieverId) {
    callRepository.endCall(callerId, context, recieverId);
  }
}
