import 'package:chatapp_clone_whatsapp/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/welcome.png',
              ),
              width: 200,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              'WELCOME',
              style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            SizedBox(height: size.height * 0.02),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                )),
          ],
        ),
      ),
    );
  }
}
