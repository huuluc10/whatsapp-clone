import 'package:chatapp_clone_whatsapp/features/select_contacts/repository/select_contact_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvier);
  return selectContactRepository.getContacts();
})