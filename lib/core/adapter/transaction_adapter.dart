import 'dart:convert';

import 'package:elevo/core/entity/transaction.dart';

class TransactionAdapter {
  Map<String, dynamic> toMap(TransactionEntity transaction) {
    return <String, dynamic>{
      'id': transaction.id,
      'value': transaction.value,
      'type': transaction.type,
      'category': transaction.category,
      'createAt': transaction.createAt.millisecondsSinceEpoch,
      'frequency': transaction.frequency,
      'description': transaction.description,
    };
  }

  static fromMap(Map<String, dynamic> map) {
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

  String toJson(TransactionEntity transaction) => json.encode(toMap(transaction));

  TransactionEntity fromJson(source) => fromMap(json.decode(source));
}
