class TransactionEntity {
  final String id;
  final double value;
  final String type;
  final String category;
  final DateTime createAt;
  final String? description;

  TransactionEntity({
    required this.id,
    required this.value,
    required this.type,
    required this.category,
    required this.createAt,
    this.description,
  });

  TransactionEntity copyWith({
    String? id,
    double? value,
    String? type,
    String? category,
    DateTime? createAt,
    String? description,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      value: value ?? this.value,
      type: type ?? this.type,
      category: category ?? this.category,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
    );
  }
}
