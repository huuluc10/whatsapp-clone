import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/controller/select_contact_controller.dart';
import 'package:chatapp_clone_whatsapp/features/group/screens/create_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);
  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chọn liên hệ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CreateGroupScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.group_add,
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Tạo nhóm mới',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: ref.watch(getContactsProvider).when(
                    data: (contactList) => ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        final contact = contactList[index];
                        return InkWell(
                          onTap: () => selectContact(ref, contact, context),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                contact.displayName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(contact.phones[0].number
                                  .replaceAll(' ', '')
                                  .toString()),
                              leading: contact.photo == null
                                  ? const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(contact.photo!),
                                      radius: 30,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    error: (err, trace) => ErrorScreen(error: err.toString()),
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
