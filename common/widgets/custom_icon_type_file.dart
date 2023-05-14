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
    print(formatTypeName);
    return formatTypeName == TypeFile.doc
        ? const FaIcon(
            FontAwesomeIcons.fileWord,
            size: 25,
            color: Colors.white,
          )
        : formatTypeName == TypeFile.docx
            ? const FaIcon(
                FontAwesomeIcons.fileWord,
                size: 25,
                color: Colors.white,
              )
            : formatTypeName == TypeFile.xlsx
                ? FaIcon(
                    FontAwesomeIcons.fileExcel,
                    size: 25,
                    color: Colors.white,
                  )
                : formatTypeName == TypeFile.pdf
                    ? const FaIcon(
                        FontAwesomeIcons.filePdf,
                        size: 25,
                        color: Colors.white,
                      )
                    : formatTypeName == TypeFile.pptx
                        ? const FaIcon(
                            FontAwesomeIcons.solidFilePowerpoint,
                            size: 25,
                            color: Colors.white,
                          )
                        : formatTypeName == TypeFile.rar
                            ? const FaIcon(
                                FontAwesomeIcons.fileZipper,
                                size: 25,
                                color: Colors.white,
                              )
                            : formatTypeName == TypeFile.zip
                                ? const FaIcon(
                                    FontAwesomeIcons.fileZipper,
                                    size: 25,
                                    color: Colors.white,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.fileCode,
                                    size: 25,
                                    color: Colors.white,
                                  );
  }
}
