import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ifind/services/auth_services.dart';
import 'package:ifind/services/user_firestore.dart';
import 'package:path/path.dart';

class AuthController {
  Future<String> createAccount(dynamic obj) async {
    String status = "";
    try {
      await authServices.createAccount(
          email: obj.email, password: obj.password);
      final photo = File(obj.photo!.path);

      final fileName = basename(photo.path);
      final destination =
          'profile/${DateTime.now().microsecondsSinceEpoch}$fileName';

      final ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(photo);
      obj.profile = await ref.getDownloadURL();
      authServices.setProfile(obj.profile);

      await userFirestoreServices.insertClient(obj);
      status = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        status = "Email is already used.";
      } else if (e.code == "invalid-email") {
        status = "Email is invalid";
      } else {
        status = "Error: ${e.code}";
      }
    }
    return status;
  }

  Future<String> loginAccount(String username, String password) async {
    await userFirestoreServices.usernameIsAlreadyUsed(username);
    if (!UserFirestoreServices.usernameAlreadyUsed) {
      return "Username is invalid";
    }
    String status = "";
    final data = await userFirestoreServices.getDataFromUsername(username);
    try {
      await authServices.loginAccount(
          email: data[UserFirestoreServices.emailColumn], password: password);
      status = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status = "Invali username and passwod.";
      } else if (e.code == "wrong-password") {
        status = "Your password is incorrect.";
      } else {
        status = "Error: ${e.code}";
      }
    }
    return status;
  }
}
