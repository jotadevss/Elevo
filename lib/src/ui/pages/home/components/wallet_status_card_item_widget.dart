import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';

class WalletStatusCardItemWidget extends StatelessWidget {
  const WalletStatusCardItemWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
    required this.isVisible,
  });

  final Color color;
  final Widget icon;
  final String label;
  final double value;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: kShadowColor.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: icon,
          ),
          Gap(height: 18),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: kGrayColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(height: 8),
          Text(
            (isVisible) ? '\$' + CurrencyFormatter.format(value.toString()) : '*****',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
