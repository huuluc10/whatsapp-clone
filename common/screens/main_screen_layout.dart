import 'package:chatapp_clone_whatsapp/common/screens/settings_options.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/oops_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/contacts_list.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenLayout extends ConsumerStatefulWidget {
  const MainScreenLayout({super.key});

  static const routeName = '/main_screen';

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
                  //TODO: màn hình chọn thành viên cho group
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
        body: const TabBarView(
          children: [
            ContactsList(),
            OopsWidget(),
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
