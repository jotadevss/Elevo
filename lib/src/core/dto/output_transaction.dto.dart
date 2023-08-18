import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OutputTransactionDTO {
  final String id;
  final double value;
  final String type;
  final String category;
  final DateTime createAt;
  final String frequency;
  final String? description;
  OutputTransactionDTO({
    required this.id,
    required this.value,
    required this.type,
    required this.category,
    required this.createAt,
    required this.frequency,
    this.description,
  });

  OutputTransactionDTO copyWith({
    String? id,
    double? value,
    String? type,
    String? category,
    DateTime? createAt,
    String? frequency,
    String? description,
  }) {
    return OutputTransactionDTO(
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

  factory OutputTransactionDTO.fromMap(Map<String, dynamic> map) {
    return OutputTransactionDTO(
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

  factory OutputTransactionDTO.fromJson(String source) => OutputTransactionDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OutputTransactionDTO(id: $id, value: $value, type: $type, category: $category, createAt: $createAt, frequency: $frequency, description: $description)';
  }
}
