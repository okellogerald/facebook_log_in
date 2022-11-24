import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/repository/auth_repository.dart';

import '../../models/user.dart';

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
  (ref) => AuthNotifier(
    ref.read(authRepositoryProvider),
  ),
);

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository repository;
  AuthNotifier(this.repository) : super(const AsyncData(null));

  void logIn() async {
    state = const AsyncValue.loading();

    try {
      final user = await repository.signInWithFacebook();
      state = AsyncValue.data(user);
    } catch (e, trace) {
      log("$e");
      state = AsyncValue.error("$e", trace);
    }
  }

  void logOut() async {
    state = const AsyncValue.loading();

    try {
      await repository.signOutFromFacebook();
      state = const AsyncValue.data(null);
    } catch (e, trace) {
      state = AsyncValue.error("$e", trace);
    }
  }
}
