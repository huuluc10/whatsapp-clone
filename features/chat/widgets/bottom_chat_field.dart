import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/enums/source_file_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/utils/colors.dart';
import '../controller/chat_controller.dart';
import 'package:flutter_sound/flutter_sound.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  const BottomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  bool isRecorderInit = false;
  bool isRecording = false;
  bool showToggle = false;
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException(
          'Quyền microphone không được cấp phép');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
          );
      isShowSendButton = false;
      setState(() {
        _messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
        );
  }

  void selectImage(SourceFile source) async {
    File? image;
    if (source == SourceFile.gallary) {
      image = await pickImage(context, SourceFile.gallary);
    } else {
      image = await pickImage(context, SourceFile.camera);
    }
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo(SourceFile source) async {
    File? video;
    if (source == SourceFile.gallary) {
      video = await pickVideo(context, SourceFile.gallary);
    } else {
      video = await pickVideo(context, SourceFile.camera);
    }

    if (video != null) {
      int sizeInBytes = await video.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 104.8) {
        showSnackBar(
            context: context,
            content: "Xin lỗi, bạn chỉ có thể gửi tập tin dưới 104MB.");
      } else {
        sendFileMessage(video, MessageEnum.video);
      }
    }
  }

  void selectDocument() async {
    final file = await pickDocument(context);
    if (file != null) {
      sendFileMessage(file, MessageEnum.doc);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      ref
          .read(chatControllerProvider)
          .sendGIFMessage(context, gif.url, widget.recieverUserId);
    }
  }

  void selectAudio() async {
    final audio = await pickAudio(context);
    if (audio != null) {
      sendFileMessage(audio, MessageEnum.audio);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  controller: _messageController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(),
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: selectGIF,
                              icon: const Icon(
                                Icons.gif,
                                color: Colors.grey,
                              ),
                            ),
                            PopupMenuButtonBottomChat(),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              selectImage(SourceFile.gallary);
                            },
                            icon: const Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              selectVideo(SourceFile.gallary);
                            },
                            icon: const Icon(
                              Icons.video_collection,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 20,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Aa",
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 2, left: 2, right: 5, top: 2),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  onTap: sendTextMessage,
                  child: Icon(
                    isShowSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PopupMenuButton<String> PopupMenuButtonBottomChat() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'video':
            selectVideo(SourceFile.camera);
            break;
          case 'image':
            selectImage(SourceFile.camera);
            break;
          case 'audio':
            selectAudio();
            break;
          default:
            selectDocument();
            break;
        }
      },
      icon: const Icon(
        Icons.attach_file,
        color: Colors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'audio',
          child: Row(
            children: const [
              Icon(Icons.audio_file),
              SizedBox(width: 7),
              Text('Âm thanh'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'document',
          child: Row(
            children: const [
              Icon(Icons.file_open),
              SizedBox(width: 7),
              Text('Tập tin'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'image',
          child: Row(
            children: const [
              Icon(Icons.camera_alt),
              SizedBox(width: 7),
              Text('Hình ảnh'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'video',
          child: Row(
            children: const [
              Icon(Icons.camera_alt),
              SizedBox(width: 7),
              Text('Video'),
            ],
          ),
        ),
      ],
    );
  }
}
