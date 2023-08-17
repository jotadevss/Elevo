// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ScheduledTransactionDTO {
  final String referenceId;
  final String frequencyType;

  ScheduledTransactionDTO({
    required this.referenceId,
    required this.frequencyType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'referenceId': referenceId,
      'frequencyType': frequencyType,
    };
  }

  factory ScheduledTransactionDTO.fromMap(Map<String, dynamic> map) {
    return ScheduledTransactionDTO(
      referenceId: map['referenceId'] as String,
      frequencyType: map['frequencyType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduledTransactionDTO.fromJson(String source) => ScheduledTransactionDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
