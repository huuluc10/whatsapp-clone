import 'dart:io';

import 'package:chatapp_clone_whatsapp/common/screens/main_screen_layout.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/repositories/common_firebase_storage_repository.dart';

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

  Future<UserModel?> getCurrentUserData() async {
    UserModel? user;
    if (auth.currentUser != null) {
      var userData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      if (userData.data() != null) {
        user = UserModel.fromMap(userData.data()!);
      }
    }
    return user;
  }

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
          codeSent: ((String verificationId, int? resendToken) {
            Navigator.pushNamed(context, OTPScreen.routeName,
                arguments: [verificationId, phoneNumber]);
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP,
      required String phoneNumber}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInformationScreen.routeName, (route) => false,
          arguments: phoneNumber);
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          'Xác thực OTP không thành công. Vui lòng thử lại sau.';
      if (e.code == 'firebase_auth/invalid-verification-code') {
        errorMessage = 'Mã OTP không đúng. Vui lòng kiểm tra và thử lại.';
      } else if (e.code == 'firebase_auth/session-expired') {
        errorMessage = 'Mã OTP đã hết hạn. Vui lòng thử lại.';
      }
      showSnackBar(context: context, content: errorMessage);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.phoneNumber.toString(),
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreenLayout(),
          ),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
