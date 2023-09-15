// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

class PieChartDTO {
  final String id;
  final Color color;
  final int percent;

  PieChartDTO({
    required this.id,
    required this.color,
    required this.percent,
  });

  PieChartDTO copyWith({
    String? id,
    Color? color,
    int? percent,
  }) {
    return PieChartDTO(
      id: id ?? this.id,
      color: color ?? this.color,
      percent: percent ?? this.percent,
    );
  }
}
