import 'dart:convert';

class WalletActivityDTO {
  final double totalBalance;
  final double totalIncomesValue;
  final double totalExpensesValue;
  final int totalIncomesAmount;
  final int totalExpensesAmount;
  final int totalAmount;

  WalletActivityDTO({
    required this.totalBalance,
    required this.totalIncomesValue,
    required this.totalExpensesValue,
    required this.totalIncomesAmount,
    required this.totalExpensesAmount,
    required this.totalAmount,
  });

  WalletActivityDTO copyWith({
    double? totalBalance,
    double? totalIncomesValue,
    double? totalExpensesValue,
    int? totalIncomesAmount,
    int? totalExpensesAmount,
    int? totalAmount,
  }) {
    return WalletActivityDTO(
      totalBalance: totalBalance ?? this.totalBalance,
      totalIncomesValue: totalIncomesValue ?? this.totalIncomesValue,
      totalExpensesValue: totalExpensesValue ?? this.totalExpensesValue,
      totalIncomesAmount: totalIncomesAmount ?? this.totalIncomesAmount,
      totalExpensesAmount: totalExpensesAmount ?? this.totalExpensesAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalBalance': totalBalance,
      'totalIncomesValue': totalIncomesValue,
      'totalExpensesValue': totalExpensesValue,
      'totalIncomesAmount': totalIncomesAmount,
      'totalExpensesAmount': totalExpensesAmount,
      'totalAmount': totalAmount,
    };
  }

  factory WalletActivityDTO.fromMap(Map<String, dynamic> map) {
    return WalletActivityDTO(
      totalBalance: map['totalBalance'] as double,
      totalIncomesValue: map['totalIncomesValue'] as double,
      totalExpensesValue: map['totalExpensesValue'] as double,
      totalIncomesAmount: map['totalIncomesAmount'] as int,
      totalExpensesAmount: map['totalExpensesAmount'] as int,
      totalAmount: map['totalAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletActivityDTO.fromJson(String source) => WalletActivityDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WalletActivityDTO(totalBalance: $totalBalance, totalIncomesValue: $totalIncomesValue, totalExpensesValue: $totalExpensesValue, totalIncomesAmount: $totalIncomesAmount, totalExpensesAmount: $totalExpensesAmount, totalAmount: $totalAmount)';
  }
}
