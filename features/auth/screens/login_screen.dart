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
      if (phoneNumber.length == 10) {
        phoneNumber = phoneNumber.replaceFirst('0', '');
      }
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+84$phoneNumber');
    } else {
      showSnackBar(
          context: context, content: 'Xin hãy nhập vào số điện thoại.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhập số điện thoại"),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Ứng dụng sẽ cần xác minh số điện thoại của bạn'),
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
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Số điện thoại'),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Hiện tại ứng dụng chỉ hỗ trợ ở Việt Nam. Xin thứ lỗi vì sự bất tiện này.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              width: 90,
              child: Center(
                  child: CustomButton(
                onPress: sendPhoneNumber,
                text: "Tiếp tục",
              )),
            ),
          ],
        ),
      ),
    );
  }
}
