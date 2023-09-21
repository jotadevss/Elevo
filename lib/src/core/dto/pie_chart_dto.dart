// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

class PieChartDTO {
  final String id;
  final Color color;
  final int percent;
  final double value;
  final String? label;

  PieChartDTO({
    required this.value,
    required this.id,
    required this.color,
    required this.percent,
    this.label = null,
  });

  PieChartDTO copyWith({
    String? id,
    Color? color,
    int? percent,
    double? value,
    String? label,
  }) {
    return PieChartDTO(
      id: id ?? this.id,
      color: color ?? this.color,
      percent: percent ?? this.percent,
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
