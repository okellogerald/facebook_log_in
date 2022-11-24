import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/models/user.dart';

final authRepositoryProvider = Provider((_) => AuthRepository());

class AuthRepository {
  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    await FacebookAuth.instance.login();

    final result = await FacebookAuth.instance.getUserData();
    log(result.toString());
    return User(
      name: result['name'],
      email: result["email"],
      image: result['picture']['data']['url'],
    );
  }

  Future<void> signOutFromFacebook() async {
    await FacebookAuth.instance.logOut();
  }
}
