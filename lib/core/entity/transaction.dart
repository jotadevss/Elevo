class TransactionEntity {
  final String id;
  final double value;
  final String type;
  final String category;
  final DateTime createAt;
  final String frequency;
  final String? description;

  TransactionEntity({
    required this.id,
    required this.value,
    required this.type,
    required this.category,
    required this.createAt,
    required this.frequency,
    this.description,
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
}
