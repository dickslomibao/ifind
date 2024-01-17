import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifind/services/user_firestore.dart';

class RegMapController extends ChangeNotifier {
  Map<String, double> coordinates = {};
  String address = "";
  Set<Marker> marker = {};

  Future<void> tapMap(LatLng position) async {
    coordinates = {
      UserFirestoreServices.lat: position.latitude,
       UserFirestoreServices.long: position.longitude,
    };
    marker.clear();
    marker.add(Marker(markerId: const MarkerId("1"), position: position));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final data = placemarks.last;
    address =
        "${data.street} ${data.subLocality} ${data.locality} ${data.subAdministrativeArea}";

    notifyListeners();
  }
}
