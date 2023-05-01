import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void singInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            String error;
            switch (e.code) {
              case 'invalid-phone-number':
                error =
                    'Invalid phone number. Please check your phone number and retry.';
                break;
              case 'session-expired':
                error = 'Authentication time has expired.';
                break;
              case 'too-many-requests':
                error =
                    'Too many requests to send verification messages in a short time.';
                break;
              case 'user-disabled':
                error = 'User disabled or locked account.';
                break;
              default:
                error = 'An unknown error occurred';
                break;
            }
            showSnackBar(context: context, content: error);
          },
          codeSent: ((String verificationId, int? resendToken) async {
            Navigator.pushNamed(context, OTPScreen.routeName,
                arguments: verificationId);
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
}
