import 'package:chatapp_clone_whatsapp/common/screens/settings_options.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/contacts_list.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/oops_screen.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:flutter/material.dart';

class MainScreenLayout extends StatelessWidget {
  const MainScreenLayout({super.key});
  static const routeName = '/main_screen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Chat App",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
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
                      'New group',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      'Settings',
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
                text: 'Chats',
              ),
              Tab(
                text: 'Calls',
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
