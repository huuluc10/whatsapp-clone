import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectContactsScreen extends StatelessWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
      ),
    );
  }
}
