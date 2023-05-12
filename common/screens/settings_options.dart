import 'package:chatapp_clone_whatsapp/common/screens/custom_opacity_wallpaper_chat_screen.dart';
import 'package:flutter/material.dart';
import '../../features/auth/screens/user_information_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, UserInformationScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Text('Profile')
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CustomWallpaperScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.wallpaper,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Text('Custom wallpaper')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
