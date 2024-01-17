import '../services/product_services.dart';

class ProductModel {
  String name;
  double price;
  String description;
  bool available;

  List<String> images = [];

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.available,
  });

  Map<String, dynamic> toMap() {
    return {
      ProductServices.nameColumn: name,
      ProductServices.priceColumn: price,
      ProductServices.descColumn: description,
      ProductServices.imagesColumn: images,
      ProductServices.availableColumn: available,
    };
  }
}
