import 'package:flutter/material.dart';
import 'package:ifind/services/user_firestore.dart';

class ServicesViewController extends ChangeNotifier {
  bool loading = true;
  Map<String, dynamic> information = {};
  Future<void> initData(String id) async {
    final data = await userFirestoreServices.getOneServicesData(id);
    information = data.data()!;
    loading = false;
    notifyListeners();
  }
}
