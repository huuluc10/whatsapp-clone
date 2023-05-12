// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewContactInfoRepositoryProvider = Provider(
    (ref) => ViewContactInfoRepository(firestore: FirebaseFirestore.instance));

class ViewContactInfoRepository {
  final FirebaseFirestore firestore;
  ViewContactInfoRepository({
    required this.firestore,
  });

  Future<UserModel?> getInfo(String uid) async {
    UserModel? user;
    var userData = await firestore.collection('users').doc(uid).get();
    user = UserModel.fromMap(userData.data()!);
    return user;
  }
}
