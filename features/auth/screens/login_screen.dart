import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login-screen';
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.isNotEmpty) {
      //Provider ref -> interact provider with provider
      //widget ref -> make widget interact with provider
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+84$phoneNumber');
    } else {
      showSnackBar(
          context: context, content: 'Fill out the phone number field.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Application will need to verify your phone number'),
            const SizedBox(height: 10),
            Center(
              child: Row(
                children: [
                  const Text('+84'),
                  const SizedBox(width: 14),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(hintText: 'Phone number'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 90,
              child: Center(
                  child: CustomButton(
                onPress: sendPhoneNumber,
                text: "Next",
              )),
            ),
          ],
        ),
      ),
    );
  }
}
