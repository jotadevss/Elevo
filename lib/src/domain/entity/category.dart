import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type,
      'iconPath': iconPath,
      'hexColor': hexColor,
    };
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      iconPath: map['iconPath'] as String,
      hexColor: map['hexColor'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryEntity.fromJson(String source) => CategoryEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
