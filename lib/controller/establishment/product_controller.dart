import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import '../../services/product_services.dart';

class ProductController extends ChangeNotifier {
  List<ProductModel> _product = [];

  Future<void> addProduct(ProductModel model) async {
    await productServices.addProduct(model);
    notifyListeners();
  }

  Future<void> initProduct(String value) async {
    _product = [];
    final data = await productServices.getAllProduct(value);

    for (var item in data.docs) {
      final tempItem = item.data();
      final tempProduct = ProductModel(
        name: tempItem[ProductServices.nameColumn],
        price: tempItem[ProductServices.priceColumn],
        description: tempItem[ProductServices.descColumn],
        available: tempItem[ProductServices.availableColumn],
      );

      for (var image in tempItem[ProductServices.imagesColumn]) {
        tempProduct.images.add(image);
      }
      print(tempProduct.name);
      _product.add(tempProduct);
    }
  }

  List<ProductModel> get products => _product;
  int get size => _product.length;
}
