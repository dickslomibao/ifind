import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:ifind/services/user_firestore.dart';

import '../../services/geo_location.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = true;
  String permissionStatus = "";

  List<Map<String, dynamic>> _services = [];
  Future<void> getPermission() async {
    permissionStatus = await geoLocationServices.getPermission();
    if (permissionStatus == 'permission-granted') {
      await geoLocationServices.getPosition();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNearbyServices() {
    return userFirestoreServices.getAllServices().snapshots();
  }
}
