import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/contacts_list.dart';
import 'package:flutter/material.dart';

class MainScreenLayout extends StatelessWidget {
  const MainScreenLayout({super.key});
  static const routeName = '/main_screen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: tabColor,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                icon: Icon(Icons.people),
              ),
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Calls',
              ),
            ],
          ),
        ),
        body: const ContactsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
