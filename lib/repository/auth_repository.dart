import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/models/user.dart';

final authRepositoryProvider = Provider((_) => AuthRepository());

class AuthRepository {
  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final result = await FacebookAuth.instance.login();
    if (result.accessToken == null) throw "Access token not found";

    final credential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final data = await FacebookAuth.instance.getUserData();

    return User(
      name: data['name'],
      email: data["email"],
      image: data['picture']['data']['url'],
      id: userCredential.user!.uid,
    );
  }

  Future<void> signOutFromFacebook() async =>
      await FacebookAuth.instance.logOut();
}
