import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryFirestoreServices {
  static String collection = "categories";

  final firestore = FirebaseFirestore.instance.collection(collection);

  Future<QuerySnapshot<Map<String, dynamic>>> getAllCategory() async {
    return firestore.orderBy('category', descending: false).get();
  }
}

CategoryFirestoreServices categoryFirestoreServices =
    CategoryFirestoreServices();
