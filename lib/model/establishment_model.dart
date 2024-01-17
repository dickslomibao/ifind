import 'package:ifind/services/user_firestore.dart';
import 'dart:io';

class EstablishmentModel {
  String businessName;
  String ownerName;
  String email;
  String username;
  String password;
  String profile = "";
  String address = "";
  List<String> services = [];
  static String type = "services";

  //for display in finalize screen only
  List<String> servicesName = [];
  Map<String, double> coordinates = {};
  File? photo;

  EstablishmentModel(
      {required this.businessName,
      required this.ownerName,
      required this.email,
      required this.username,
      required this.password});

  Map<String, dynamic> toMap() => {
    
        UserFirestoreServices.businessNameColumn: businessName,
        UserFirestoreServices.ownerColumn: ownerName,
        UserFirestoreServices.emailColumn: email,
        UserFirestoreServices.usernameColumn: username,
        UserFirestoreServices.servicesColumn: services,
        UserFirestoreServices.coordinatesColumn: coordinates,
        UserFirestoreServices.typeColumn: type,
        UserFirestoreServices.profileColumn: profile,
        UserFirestoreServices.addressColumn: address,
  };
}
