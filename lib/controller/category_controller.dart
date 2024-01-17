import 'package:flutter/material.dart';
import 'package:ifind/model/category_model.dart';
import 'package:ifind/services/category_firestore.dart';

class CategoryController extends ChangeNotifier {
  List<CategoryModel> category = [];
  bool isLoading = true;
  Future<void> getAllCategory() async {
    final data = await categoryFirestoreServices.getAllCategory();
    category = data.docs
        .map((e) =>
            CategoryModel(id: e['id'], name: e['category'], status: false))
        .toList();
    isLoading = false;
    notifyListeners();
  }

  void reBuild() {
    notifyListeners();
  }
}
