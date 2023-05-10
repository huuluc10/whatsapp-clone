// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerStatefulWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  final String phoneNumber;

  OTPScreen(this.verificationId, this.phoneNumber);

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  int time = 60;
  late Stream<int> _timerStream;
  late StreamSubscription<int> _timerSubscription;

  Future<void> updateTimeToVerify() {
    if (time > 0) {
      return Future.delayed(const Duration(seconds: 1)).then((value) {
        time--;
      });
    } else {
      return Future.value();
    }
  }

  void verifyOTP(
      WidgetRef ref, BuildContext context, String userOTP, String phoneNumber) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, widget.verificationId, userOTP, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6 && time >= 0) {
                    verifyOTP(ref, context, value.trim(), widget.phoneNumber);
                  }
                },
              ),
            ),
            FutureBuilder(
              future: updateTimeToVerify(),
              builder: (context, snapshot) => Text(
                time.toString(),
              ),
            ),
            time == 0
                ? const Text(
                    'Verification time has expired, please perform the action again.')
                : Container(),
          ],
        ),
      ),
    );
  }
}
