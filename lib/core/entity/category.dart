// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryEntity {
  final String id;
  final String title;
  final String type;
  final String iconPath;
  final int hexColor;

  CategoryEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.iconPath,
    required this.hexColor,
  });

  CategoryEntity copyWith({
    String? id,
    String? title,
    String? type,
    String? iconPath,
    int? hexColor,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      iconPath: iconPath ?? this.iconPath,
      hexColor: hexColor ?? this.hexColor,
    );
  }
}
