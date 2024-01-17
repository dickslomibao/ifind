import 'package:ifind/services/user_firestore.dart';

class ClientModel {
  String firstname;
  String lastname;
  String email;
  String username;
  String password;
  static String type = "client";
  ClientModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        UserFirestoreServices.firstnameColumn: firstname,
        UserFirestoreServices.lastnameColumn: lastname,
        UserFirestoreServices.emailColumn: email,
        UserFirestoreServices.usernameColumn: username,
        UserFirestoreServices.typeColumn: type,
      };
}
