class CategoryData {
  final String id;
  final String name;
  final String arabic;
  final String imageUrl;
  final String description;
  final bool isActive;

  CategoryData( {
    required this.arabic,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.isActive,
  });

  factory CategoryData.fromFireStore(String docId, Map<String, dynamic> data) {
    return CategoryData(
      id: docId,
      arabic: data['arabic'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      isActive: data['isActive'] ?? false,
    );
  }
}
