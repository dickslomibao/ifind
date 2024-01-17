import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifind/services/auth_services.dart';

import '../model/product_model.dart';

class ProductServices {
  static String nameColumn = 'name';
  static String priceColumn = 'price';
  static String descColumn = 'description';
  static String imagesColumn = 'images';
  static String availableColumn = 'available';

  final firestore = FirebaseFirestore.instance.collection('products');

  //for productControllerr
  Future<void> addProduct(ProductModel model) async {
    firestore
        .doc(authServices.getUid())
        .collection('product')
        .add(model.toMap());
  }

  //for productControllerr
  Future<QuerySnapshot<Map<String, dynamic>>> getAllProduct(String value) async {
    return firestore.doc(value).collection('product').get();
  }
}

ProductServices productServices = ProductServices();
