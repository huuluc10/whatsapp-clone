// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupInfoScreen extends ConsumerWidget {
  const GroupInfoScreen({
    super.key,
    required this.uid,
    required this.name,
  });
  static const routeName = '/group-info';
  final String uid;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold();
  }
}
