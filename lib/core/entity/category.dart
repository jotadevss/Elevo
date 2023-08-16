class CategoryEntity {
  final String id;
  final String title;
  final String iconPath;
  final int hexColor;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.hexColor,
  });

  CategoryEntity copyWith({
    String? id,
    String? title,
    String? iconPath,
    int? hexColor,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      hexColor: hexColor ?? this.hexColor,
    );
  }
}
