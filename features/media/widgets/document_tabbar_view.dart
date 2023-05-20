// ignore_for_file: must_be_immutable

import 'package:chatapp_clone_whatsapp/features/chat/widgets/document_item.dart';
import 'package:chatapp_clone_whatsapp/models/document.dart';
import 'package:flutter/material.dart';

class DocumentTabarView extends StatelessWidget {
  Document documents = Document();
  final ScrollController fileController = ScrollController();

  DocumentTabarView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> link = documents.documents;
    List<String> linkId = documents.documentsId;
    List<String> recieversId = documents.recieverUsersId;
    return ListView.builder(
      controller: fileController,
      itemCount: link.length,
      itemBuilder: (context, index) => Card(
        child: DocumentItem(
          mesage: link.elementAt(index),
          messageId: linkId.elementAt(index),
          recieverUserId: recieversId.elementAt(index),
        ),
      ),
    );
  }
}
