// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/call/screens/call_pickup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/chat_list.dart';
import 'package:chatapp_clone_whatsapp/features/group/screens/group_info.dart';
import 'package:chatapp_clone_whatsapp/features/media/screens/media_screen.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/screens/contact_info_screen.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import '../widgets/bottom_chat_field.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;

  const ChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  double _currentSliderValue = 0.3;

  void getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? sliderValue = prefs.getDouble('sliderValue') ?? 0.3;
    _currentSliderValue = sliderValue;
    setState(() {});
  }

  void makeVideoCall() {
    makeCall(
      ref: ref,
      context: context,
      recieverUid: widget.uid,
      recieverName: widget.name,
      recieverProfilePic: widget.profilePic,
      isGroupChat: widget.isGroupChat,
    );
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = false;
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: widget.isGroupChat
              ? Text(widget.name)
              : StreamBuilder<UserModel>(
                  stream:
                      ref.read(authControllerProvider).userDataById(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    } else {
                      isOnline = snapshot.data!.isOnline;
                      return Column(
                        children: [
                          Text(widget.name),
                          Text(
                            snapshot.data!.isOnline
                                ? 'Đang hoạt động'
                                : 'Ngoại tuyến',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    }
                  },
                ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: makeVideoCall,
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {
                showSnackBar(
                    context: context, content: 'Tính năng chưa phát triển');
              },
              icon: const Icon(Icons.call),
            ),
            PopupMenuButton<String>(
              color: appBarColor,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onSelected: (value) {
                if (value == 'contact-info') {
                  Navigator.pushNamed(
                    context,
                    ContactInfo.routeName,
                    arguments: {
                      'uid': widget.uid,
                      'name': widget.name,
                      'isOnline': isOnline,
                    },
                  );
                } else if (value == 'group-info') {
                  Navigator.pushNamed(
                    context,
                    GroupInfoScreen.routeName,
                    arguments: {
                      'uid': widget.uid,
                      'name': widget.name,
                    },
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    MediaScreen.routeName,
                    arguments: {
                      'name': widget.name,
                    },
                  );
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                !widget.isGroupChat
                    ? const PopupMenuItem(
                        value: "contact-info",
                        child: SizedBox(
                          width: 130,
                          child: Text(
                            'Xem thông tin liên hệ',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    : const PopupMenuItem(
                        value: "group-info",
                        child: SizedBox(
                          width: 130,
                          child: Text(
                            'Xem thông tin nhóm',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                const PopupMenuItem(
                  value: 'media',
                  child: SizedBox(
                    width: 130,
                    child: Text(
                      'Đa phương tiện',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/wallpaper.jpg'),
              fit: BoxFit.fill,
              opacity: _currentSliderValue,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ChatList(
                  recieverUserId: widget.uid,
                  isGroupChat: widget.isGroupChat,
                ),
              ),
              BottomChatField(
                recieverUserId: widget.uid,
                isGroupChat: widget.isGroupChat,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
