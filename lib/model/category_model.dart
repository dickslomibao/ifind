class CategoryModel {
  String id;
  String name;
  bool status;

  CategoryModel({
    required this.id,
    required this.name,
    required this.status,
  });

  void toggleStatus() {
    status = !status;
  }
  
}
