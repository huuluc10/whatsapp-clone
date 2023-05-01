import 'package:chatapp_clone_whatsapp/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.singInWithPhone(context, phoneNumber);
  }
}
