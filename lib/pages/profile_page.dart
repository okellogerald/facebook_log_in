import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/manager/auth/auth_state_notifier.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          ref.watch(authStateProvider).maybeWhen(
              data: (user) {
                if (user == null) return Container();
                return Column(
                  children: [
                    Text(user.name),
                    Text(user.email),
                    if (user.image != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.image!),
                      )
                  ],
                );
              },
              orElse: () => Container()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text("Log out"),
          )
        ],
      ),
    );
  }
}
