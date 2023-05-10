import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';
final selectContactRepositoryProvier = Provider((ref) => SelectContactRepository(firestore: FirebaseFirestore.instance,),);
class SelectContactRepository{
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async{
    List<Contact> contacts = [];
    try{
        if(await FlutterContacts.requestPermission()){
          contacts = await FlutterContacts.getContacts(withProperties: true);
        }
    }catch(e){
      debugPrint(e.toString());
    }
    return contacts;
  }
  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum  = selectedContact.phones[0].number.replaceAll('', '');
        if(selectedPhoneNum == userData.phoneNumber){
          isFound = true;
          Navigator.pushNamed(context, ChatScreen.routeName);
        }
      }
      if(!isFound){
        showSnackBar(context: context, content: 'This number is not exist on this app.');
      }
    }
    catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}