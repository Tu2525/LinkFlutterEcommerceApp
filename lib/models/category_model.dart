class CategoryModel {
  final String id;
  final String imgPath;
  final String categoryName;
  final String description;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.imgPath,
    required this.description,
    required this.isActive,
  });

  factory CategoryModel.fromFireStore(String docId, Map<String, dynamic> data) {
    return CategoryModel(
      id: docId,
      categoryName: data['name'] ?? '',
      imgPath: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      isActive: data['isActive'] ?? false,
    );
  }
}
