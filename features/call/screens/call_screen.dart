// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agora_uikit/agora_uikit.dart';
import 'package:chatapp_clone_whatsapp/features/call/controller/call_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/config/agora_config.dart';
import 'package:chatapp_clone_whatsapp/models/call.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({
    super.key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
    required this.name,
  });

  final String channelId;
  final Call call;
  final bool isGroupChat;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late AgoraClient client;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        username: widget.name,
        tokenUrl: AgoraConfig.baseUrl,
      ),
    );
    await client.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client),
                  AgoraVideoButtons(
                    client: client,
                    disconnectButtonChild: IconButton(
                      onPressed: () async {
                        await client.engine.leaveChannel();
                        ref.read(callControllerProvider).endCall(
                            widget.call.callerId,
                            context,
                            widget.call.recieverId,
                            widget.isGroupChat);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.call_end),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
