// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: blackColor),
      ),
    );
  }
}
