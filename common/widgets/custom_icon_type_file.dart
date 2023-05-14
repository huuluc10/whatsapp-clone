// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chatapp_clone_whatsapp/common/enums/type_file_enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconTypeFile extends StatelessWidget {
  const CustomIconTypeFile({
    Key? key,
    required this.typeName,
  }) : super(key: key);
  final String typeName;

  @override
  Widget build(BuildContext context) {
    final TypeFile formatTypeName = typeName.toLowerCase().toEnum();
    switch (formatTypeName) {
      case TypeFile.doc:
      case TypeFile.docx:
        return const FaIcon(
          FontAwesomeIcons.fileWord,
          size: 25,
          color: Colors.white,
        );
      case TypeFile.xlsx:
        return const FaIcon(
          FontAwesomeIcons.fileExcel,
          size: 25,
          color: Colors.white,
        );
      case TypeFile.pdf:
        return const FaIcon(
          FontAwesomeIcons.filePdf,
          size: 25,
          color: Colors.white,
        );
      case TypeFile.pptx:
        return const FaIcon(
          FontAwesomeIcons.solidFilePowerpoint,
          size: 25,
          color: Colors.white,
        );
      case TypeFile.rar:
      case TypeFile.zip:
        return const FaIcon(
          FontAwesomeIcons.fileZipper,
          size: 25,
          color: Colors.white,
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.fileCode,
          size: 25,
          color: Colors.white,
        );
    }
  }
}
