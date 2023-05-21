import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/user_model.dart';

final selectContactRepositoryProvier = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void inviteFriend(BuildContext context, phoneNumber) async {
    showSnackBar(
        context: context, content: 'This number is not exist on this app.');
    String? confirm = await showConfirmDialog(
        context, "Do you want to share this app to your friend ");
    // print(confirm);
    if (confirm == 'ok') {
      final Uri smsLaunchUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: <String, String>{
          'body': Uri.encodeComponent(
              'I am using this app to chat, you can download and instal to use with me at https://drive.google.com/drive/folders/10EIZybrPR83rPOKWqMw1USqFIZgQZAfe?usp=sharing'),
        },
      );
      if (await canLaunchUrl(smsLaunchUri)) {
        await launchUrl(smsLaunchUri);
      } else {
        // print('Can not to send message');
        showSnackBar(context: context, content: "Can not to send message");
      }
    }
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    String selectedPhoneNum = '';

    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        selectedPhoneNum = selectedContact.phones[0].number
            .replaceAll(' ', '')
            .replaceFirst('0', '+84');
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(
            context,
            ChatScreen.routeName,
            arguments: {
              'name': userData.name,
              'uid': userData.uid,
              'isGroupChat': false,
              'profilePic': userData.profilePic,
            },
          );
        }
      }
      if (!isFound) {
        inviteFriend(context, selectedContact);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
