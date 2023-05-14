import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/chat_list.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/loader.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/media_chat/screens/media_screen.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/screens/contact_info_screen.dart';
import 'package:chatapp_clone_whatsapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_chat_field.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key, required this.name, required this.uid})
      : super(key: key);
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;

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

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(widget.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else {
              isOnline = snapshot.data!.isOnline;
              return Column(
                children: [
                  Text(widget.name),
                  Text(
                    snapshot.data!.isOnline ? 'Đang hoạt động' : 'Ngoại tuyến',
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
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
              } else if (value == 'media') {
                Navigator.pushNamed(
                  context,
                  MediaScreen.routeName,
                  arguments: widget.name,
                );
              } else {
                //TODO: xóa cuộc trò chuyện
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(
                value: "contact-info",
                child: SizedBox(
                  width: 130,
                  child: Text(
                    'Xem thông tin liên hệ',
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
              const PopupMenuItem(
                value: 'clear',
                child: SizedBox(
                  width: 130,
                  child: Text(
                    'Xóa cuộc trò chuyện',
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
              ),
            ),
            BottomChatField(
              recieverUserId: widget.uid,
            )
          ],
        ),
      ),
    );
  }
}
