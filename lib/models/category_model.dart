
class CategoryModel {
  final String imgPath;
  final String categoryName;
  final String description;
  final bool isActive;

  CategoryModel({
    required this.categoryName,
    required this.imgPath,
    required this.description,
    required this.isActive,
  });

  factory CategoryModel.fromFireStore(Map<String, dynamic> data) {
    return CategoryModel(
      categoryName: data['name'] ?? '',
      imgPath: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      isActive: data['isActive'] ?? false,
    );
  }
}
