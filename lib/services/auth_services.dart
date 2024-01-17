import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;
  static String type = "";
  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginAccount({
    required String email,
    required String password,
  }) async {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String? getUid() {
    return auth.currentUser?.uid;
  }

  Stream authChange() {
    return auth.authStateChanges();
  }

  Future<void> setProfile(String profile) async {
    await auth.currentUser!.updatePhotoURL(profile);
  }

  Future<void> setName(String name) async {
    await auth.currentUser!.updateDisplayName(name);
  }
}

AuthServices authServices = AuthServices();
