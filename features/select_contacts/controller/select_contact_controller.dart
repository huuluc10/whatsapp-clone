import 'package:chatapp_clone_whatsapp/features/select_contacts/repository/select_contact_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvier);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref){
  final selectContactRepository = ref.watch(selectContactRepositoryProvier);
  return SelectContactController(ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContactController{
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });
  void selectContact(Contact selectedContact, BuildContext context) {
     selectContactRepository.selectContact(selectedContact, context);
  }
}