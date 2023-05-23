// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/custom_icon_type_file.dart';
import 'package:chatapp_clone_whatsapp/features/chat/controller/chat_controller.dart';

class DocumentItem extends ConsumerStatefulWidget {
  const DocumentItem({
    Key? key,
    required this.mesage,
    required this.messageId,
    required this.recieverUserId,
  }) : super(key: key);
  final String mesage;
  final String messageId;
  final String recieverUserId;

  @override
  ConsumerState<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends ConsumerState<DocumentItem> {
  @override
  void initState() {
    super.initState();
  }

  Future<File?> downloadFile(String url, String fileName) async {
    showSnackBar(context: context, content: "Đang tải");
    File? file = await downloadFileFromServer(
      context,
      widget.mesage,
      fileName,
    );

    return file;
  }

  // Lấy thông tin của tệp tin trên Firebase Storage
  Future<Map<String, dynamic>> getFileMetadata() async {
    Map<String, dynamic> info =
        await ref.watch(chatControllerProvider).getFileMetadata(
              context: context,
              recieverUserId: widget.recieverUserId,
              messageEnum: MessageEnum.doc,
              messageId: widget.messageId,
            );
    String name = info['name'];
    info['type'] = name.substring(name.lastIndexOf('.') + 1).toUpperCase();
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getFileMetadata(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final info = snapshot.data!;
        final nameFile = info['name'];
        final sizeFile = info['size'];
        final typeFile = info['type'];
        return InkWell(
          onTap: () async {
            String? confirm = await showConfirmDialog(
                context, "Bạn đang muốn tải file xuống đúng không?");
            if (confirm == 'ok') {
              File? file = await downloadFile(widget.mesage, nameFile);
              if (file != null) {
                showSnackBar(context: context, content: 'Tải file thành công');
              } else {
                showSnackBar(context: context, content: 'Tải file thất bại');
              }
            }
          },
          child: Container(
            constraints: const BoxConstraints(minWidth: 70),
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(60),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomIconTypeFile(typeName: typeFile),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameFile,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text('$sizeFile - $typeFile'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
