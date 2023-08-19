// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionEntity {
  final String id;
  final double value;
  final String type;
  final String category;
  final DateTime createAt;
  final String? frequency;
  final String? description;

  TransactionEntity({
    required this.id,
    required this.value,
    required this.type,
    required this.category,
    required this.createAt,
    this.frequency = '',
    this.description = '',
  });

  TransactionEntity copyWith({
    String? id,
    double? value,
    String? type,
    String? category,
    DateTime? createAt,
    String? frequency,
    String? description,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      value: value ?? this.value,
      type: type ?? this.type,
      category: category ?? this.category,
      createAt: createAt ?? this.createAt,
      frequency: frequency ?? this.frequency,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'type': type,
      'category': category,
      'createAt': createAt.millisecondsSinceEpoch,
      'frequency': frequency,
      'description': description,
    };
  }

  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'] as String,
      value: map['value'] as double,
      type: map['type'] as String,
      category: map['category'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      frequency: map['frequency'] as String,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionEntity.fromJson(String source) => TransactionEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
