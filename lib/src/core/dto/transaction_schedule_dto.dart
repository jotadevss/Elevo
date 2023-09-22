// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionScheduleDTO {
  final String transactionId;
  final String frequencyRef;

  TransactionScheduleDTO({
    required this.transactionId,
    required this.frequencyRef,
  });

  TransactionScheduleDTO copyWith({
    String? transactionId,
    String? frequencyRef,
  }) {
    return TransactionScheduleDTO(
      transactionId: transactionId ?? this.transactionId,
      frequencyRef: frequencyRef ?? this.frequencyRef,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'frequencyRef': frequencyRef,
    };
  }

  factory TransactionScheduleDTO.fromMap(Map<String, dynamic> map) {
    return TransactionScheduleDTO(
      transactionId: map['transactionId'] as String,
      frequencyRef: map['frequencyRef'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionScheduleDTO.fromJson(String source) => TransactionScheduleDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TransactionScheduleDTO(transactionId: $transactionId, frequencyRef: $frequencyRef)';

  @override
  bool operator ==(covariant TransactionScheduleDTO other) {
    if (identical(this, other)) return true;

    return other.transactionId == transactionId && other.frequencyRef == frequencyRef;
  }

  @override
  int get hashCode => transactionId.hashCode ^ frequencyRef.hashCode;
}
