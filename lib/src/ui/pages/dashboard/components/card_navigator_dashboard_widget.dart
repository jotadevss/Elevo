import 'package:elevo/src/constants.dart';
import 'package:flutter/material.dart';

class CardNavigatorDashboardWidget extends StatelessWidget {
  const CardNavigatorDashboardWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.func,
  });

  final String label;
  final Icon icon;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kGrayColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'See details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: kGrayColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
