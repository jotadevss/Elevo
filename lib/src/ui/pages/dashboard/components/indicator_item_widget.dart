import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({
    super.key,
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  final String label;
  final double value;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 6,
            ),
            Gap(width: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '\$' + CurrencyFormatter.format(value.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(width: 8),
            CircleAvatar(
              backgroundColor: kGrayColor.withOpacity(0.3),
              radius: 3,
            ),
            Gap(width: 8),
            Text(
              percent.toString() + '%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }
}
