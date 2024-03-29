import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/screens/custom_opacity_wallpaper_chat_screen.dart';
import 'package:chatapp_clone_whatsapp/common/screens/main_screen_layout.dart';
import 'package:chatapp_clone_whatsapp/common/screens/video_image_sceen.dart';
import 'package:chatapp_clone_whatsapp/common/screens/welcom_screen.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/login_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:chatapp_clone_whatsapp/features/chat/screens/chat_screen.dart';
import 'package:chatapp_clone_whatsapp/features/group/screens/group_info.dart';
import 'package:chatapp_clone_whatsapp/features/media/screens/media_screen.dart';
import 'package:chatapp_clone_whatsapp/features/group/screens/create_group_screen.dart';
import 'package:chatapp_clone_whatsapp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:chatapp_clone_whatsapp/features/view_contact_info/screens/contact_info_screen.dart';
import 'package:flutter/material.dart';
import 'common/screens/settings_options.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final verificationId = arguments[0] as String;
      final phoneNumber = arguments[1] as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
          phoneNumber: phoneNumber,
        ),
      );
    case UserInformationScreen.routeName:
      // final bool isNewUser = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      // final bool isNewUser = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'] as bool;
      final profilePic = arguments['profilePic'];
      print(profilePic);
      // final bool isNewUser = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          profilePic: profilePic,
        ),
      );

    case MainScreenLayout.routeName:
      return MaterialPageRoute(
        builder: (context) => const MainScreenLayout(),
      );
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );
    case ContactInfo.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isOnline = arguments['isOnline'];
      return MaterialPageRoute(
        builder: (context) =>
            ContactInfo(uid: uid, name: name, isOnline: isOnline),
      );
    case CustomWallpaperScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CustomWallpaperScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      );
    case VideoImageScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final message = arguments['message'] as String;
      final messageId = arguments['messageId'] as String;
      final messageEnum = arguments['messageEnum'] as MessageEnum;
      return MaterialPageRoute(
        builder: (context) => VideoImageScreen(
          message: message,
          messageId: messageId,
          messageEnum: messageEnum,
        ),
      );
    case MediaScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      return MaterialPageRoute(
        builder: (context) => MediaScreen(name: name),
      );
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );
    case GroupInfoScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => GroupInfoScreen(name: name, uid: uid),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'Trang này không tồn tại'),
        ),
      );
  }
}
