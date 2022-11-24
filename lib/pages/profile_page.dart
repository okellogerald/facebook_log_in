import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/manager/auth/auth_state_notifier.dart';
import 'package:test_project/pages/home_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, next) {
      next.maybeWhen(
          data: (user) {
            if (user == null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
                (route) => false,
              );
            }
          },
          orElse: () {});
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(authStateProvider).maybeWhen(
                data: (user) {
                  if (user == null) return Container();
                  return Column(
                    children: [
                      if (user.image != null)
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(user.image!),
                        ),
                      const SizedBox(height: 30),
                      Text(user.name),
                      const SizedBox(height: 10),
                      Text(user.email),
                    ],
                  );
                },
                orElse: () => Container()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authStateProvider.notifier).logOut();
              },
              child: const Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}
