import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/controller/select_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactGroup extends ConsumerStatefulWidget {
  const SelectContactGroup({super.key});

  @override
  ConsumerState<SelectContactGroup> createState() => _SelectContactGroupState();
}

class _SelectContactGroupState extends ConsumerState<SelectContactGroup> {
  List<int> selectedContactIndex = [];

  void selectContact(int index, Contact contact) {
    setState(() {
      if (selectedContactIndex.contains(index)) {
        selectedContactIndex.remove(index);
        ref.read(selectGroupContacts.notifier).state.remove(contact);
      } else {
        selectedContactIndex.add(index);
        ref.read(selectGroupContacts.notifier).state.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
        data: (contactList) => Container(
              child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  final name = contact.displayName;
                  final phoneNumbber = contact.phones[0].number
                      .replaceAll(' ', '')
                      .replaceFirst('0', '+84');
                  return InkWell(
                    onTap: () {
                      selectContact(index, contact);
                    },
                    child: ListTile(
                      leading: selectedContactIndex.contains(index)
                          ? const Icon(Icons.done)
                          : null,
                      title: Text(
                        name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(phoneNumbber),
                    ),
                  );
                },
              ),
            ),
        error: (error, stackTrace) => ErrorScreen(error: error.toString()),
        loading: () => const Loader());
  }
}
