// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatapp_clone_whatsapp/common/screens/settings_options.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/contacts_list.dart';
import 'package:chatapp_clone_whatsapp/features/group/screens/create_group_screen.dart';
import 'package:chatapp_clone_whatsapp/features/group/widgets/group_list.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:chatapp_clone_whatsapp/models/audio.dart';
import 'package:chatapp_clone_whatsapp/models/document.dart';
import 'package:chatapp_clone_whatsapp/models/image.dart';
import 'package:chatapp_clone_whatsapp/models/video.dart';

class MainScreenLayout extends ConsumerStatefulWidget {
  static const routeName = '/main_screen';

  const MainScreenLayout({super.key});

  @override
  ConsumerState<MainScreenLayout> createState() => _MainScreenLayoutState();
}

class _MainScreenLayoutState extends ConsumerState<MainScreenLayout>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    setOnline();
    WidgetsBinding.instance.addObserver(this);
    Audio audios = Audio();
    audios.removeList();
    Document documents = Document();
    documents.removeList();
    Img images = Img();
    images.removeList();
    Video video = Video();
    video.removeList();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void setOnline() async {
    ref.read(authControllerProvider).setUserState(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Ứng dụng nhắn tin",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              color: appBarColor,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onSelected: (value) {
                if (value == 'newGroup') {
                  Navigator.pushNamed(context, CreateGroupScreen.routeName);
                } else {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                const PopupMenuItem(
                  value: "newGroup",
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      'Tạo nhóm',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      'Cài đặt',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            indicatorColor: tabColor,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: 'Trò chuyện',
              ),
              Tab(
                text: 'Nhóm',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            ContactsList(),
            GroupList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectContactsScreen.routeName);
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
