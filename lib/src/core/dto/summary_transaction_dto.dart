// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:elevo/src/domain/entity/transaction.dart';

class TransactionSummaryDTO {
  final double totalAmount;
  final List<TransactionEntity> transactions;

  TransactionSummaryDTO({
    required this.totalAmount,
    required this.transactions,
  });

  TransactionSummaryDTO copyWith({
    double? totalAmount,
    List<TransactionEntity>? transactions,
  }) {
    return TransactionSummaryDTO(
      totalAmount: totalAmount ?? this.totalAmount,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalAmount': totalAmount,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionSummaryDTO.fromMap(Map<String, dynamic> map) {
    return TransactionSummaryDTO(
      totalAmount: map['totalAmount'] as double,
      transactions: List<TransactionEntity>.from(
        (map['transactions'] as List<int>).map<TransactionEntity>(
          (x) => TransactionEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionSummaryDTO.fromJson(String source) => TransactionSummaryDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TransactionSummaryDTO(totalAmount: $totalAmount, transactions: $transactions)';

  @override
  bool operator ==(covariant TransactionSummaryDTO other) {
    if (identical(this, other)) return true;

    return other.totalAmount == totalAmount && listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => totalAmount.hashCode ^ transactions.hashCode;
}
