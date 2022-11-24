import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/manager/auth/auth_state_notifier.dart';
import 'package:test_project/pages/profile_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, next) {
      next.maybeWhen(
          data: (user) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
                (route) => false,
              ),
          orElse: () {});
    });

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ref.watch(authStateProvider).maybeWhen(
                loading: () => const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircularProgressIndicator(),
                ),
                orElse: () => Container(),
              ),
          ElevatedButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).logIn();
            },
            child: const Text("Sign In With Facebook"),
          )
        ],
      ),
    ));
  }
}
