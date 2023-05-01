import 'package:chatapp_clone_whatsapp/common/widgets/error.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/login_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:chatapp_clone_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:flutter/material.dart';

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
      final verificationID = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => UserInformationScreen(
                phoneNumber: verificationID,
              ));
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page does not exist'),
        ),
      );
  }
}
