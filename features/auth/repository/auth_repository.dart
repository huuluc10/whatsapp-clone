import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void  singInWithPhone(BuildContext context ,String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      }, verificationFailed: (e) {
        throw Exception(e.message);
      }, codeSent: ((String verificationId, int? resendToken) async {
        Navigator.push(context, OTPScreen.routeName, argumemnts: verificationId,);
      }), codeAutoRetrievalTimeout: (String verificationId) {

      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
    }
  }
}