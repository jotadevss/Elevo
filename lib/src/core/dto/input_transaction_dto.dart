// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:elevo/src/domain/entity/transaction.dart';

class InputTransactionDTO {
  final double value;
  final String type;
  final String category;
  final DateTime createAt;
  final String? frequency;
  final String? description;

  InputTransactionDTO({
    required this.value,
    required this.type,
    required this.category,
    required this.createAt,
    this.frequency,
    this.description,
  });

  InputTransactionDTO copyWith({
    double? value,
    String? type,
    String? category,
    DateTime? createAt,
    String? frequency,
    String? description,
  }) {
    return InputTransactionDTO(
      value: value ?? this.value,
      type: type ?? this.type,
      category: category ?? this.category,
      createAt: createAt ?? this.createAt,
      frequency: frequency ?? this.frequency,
      description: description ?? this.description,
    );
  }

  static TransactionEntity toTransaction(String id, InputTransactionDTO dto) {
    return TransactionEntity(
      id: id,
      value: dto.value,
      type: dto.type,
      category: dto.category,
      createAt: dto.createAt,
      frequency: dto.frequency,
      description: dto.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'type': type,
      'category': category,
      'createAt': createAt.millisecondsSinceEpoch,
      'frequency': frequency,
      'description': description,
    };
  }

  factory InputTransactionDTO.fromMap(Map<String, dynamic> map) {
    return InputTransactionDTO(
      value: map['value'] as double,
      type: map['type'] as String,
      category: map['category'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      frequency: map['frequency'] != null ? map['frequency'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InputTransactionDTO.fromJson(String source) => InputTransactionDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InputTransactionDTO(value: $value, type: $type, category: $category, createAt: $createAt, frequency: $frequency, description: $description)';
  }

  @override
  bool operator ==(covariant InputTransactionDTO other) {
    if (identical(this, other)) return true;

    return other.value == value &&
        other.type == type &&
        other.category == category &&
        other.createAt == createAt &&
        other.frequency == frequency &&
        other.description == description;
  }

  @override
  int get hashCode {
    return value.hashCode ^ type.hashCode ^ category.hashCode ^ createAt.hashCode ^ frequency.hashCode ^ description.hashCode;
  }
}
