// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/repository/view_contact_info_repository.dart';

final viewContactInfoControllerProvider = Provider((ref) {
  final viewContactInfo = ref.watch(viewContactInfoRepositoryProvider);
  return ViewContactInfoController(viewContactInfoRepository: viewContactInfo);
});

class ViewContactInfoController {
  final ViewContactInfoRepository viewContactInfoRepository;

  ViewContactInfoController({
    required this.viewContactInfoRepository,
  });

  Future<UserModel?> getInfo(String uid) async {
    UserModel? user = await viewContactInfoRepository.getInfo(uid);
    return user;
  }
}
