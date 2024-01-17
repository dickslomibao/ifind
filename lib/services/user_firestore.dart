import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifind/services/auth_services.dart';

import '../model/establishment_model.dart';

class UserFirestoreServices {
  static String businessNameColumn = "services_name";
  static String ownerColumn = "owner";
  static String servicesColumn = "services";
  static String coordinatesColumn = "coordinates";
  static String lat = "latitude";
  static String long = "longitude";
  static String addressColumn = "address";

  static String firstnameColumn = "firstname";
  static String lastnameColumn = "lastname";
  static String profileColumn = "profile";
  static String emailColumn = "email";
  static String usernameColumn = "username";

  static String usersCollection = "users";
  static String typeColumn = "type";

  static bool usernameAlreadyUsed = false;

  final firestore = FirebaseFirestore.instance.collection(usersCollection);

  Future<void> insertClient(dynamic data) async {
    await firestore.doc(authServices.getUid()).set(data.toMap());
  }

  Future<void> usernameIsAlreadyUsed(String value) async {
    final data = await firestore.where(usernameColumn, isEqualTo: value).get();
    usernameAlreadyUsed = data.size > 0;
  }

  Future<Map<String, dynamic>> getDataFromUsername(String value) async {
    final data = await firestore.where(usernameColumn, isEqualTo: value).get();
    return data.docs.first.data();
  }

  Future<Map<String, dynamic>?> getClientData() async {
    final data = await firestore.doc(authServices.getUid()).get();
    return data.data();
  }

  Query<Map<String, dynamic>> getAllServices() {
    return firestore.where(typeColumn, isEqualTo: EstablishmentModel.type);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getOneServicesData(String value) async {
    return await firestore.doc(value).get();
  }
}

UserFirestoreServices userFirestoreServices = UserFirestoreServices();
