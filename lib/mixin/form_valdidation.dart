import 'package:flutter/widgets.dart';
import 'package:ifind/services/user_firestore.dart';

class FormValidate {
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "Firstname is required.";
    }
    if (!_validateName(value)) {
      return "Firstname is invalid.";
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Lastname is required.";
    }
    if (!_validateName(value)) {
      return "Lastname is invalid.";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required.";
    }
    return null;
  }

  String? validateUserName(String value) {
    if (value.isEmpty) {
      return "Username is required.";
    }
    if (value.length < 7) {
      return "Username is minimum of 7 characters.";
    }
    if (UserFirestoreServices.usernameAlreadyUsed) {
      return "Username is already used.";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required.";
    }
    if (value.length < 7) {
      return "Password is minimum of 7 characters.";
    }
    return null;
  }

  String? validateComfirmPassword(String value, String comfirm) {
    if (value.isEmpty) {
      return "Comfirm Password is required.";
    }
    if (value != comfirm) {
      return "Password didn't matched.";
    }
    return null;
  }

  bool _validateName(String name) {
    RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(name);
  }

  String sanitaize(TextEditingController c) {
    String data = c.text.trim();
    return data;
  }
}
