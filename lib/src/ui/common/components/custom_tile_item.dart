import 'dart:math' as math;

import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

class CustomTileItem extends StatelessWidget {
  const CustomTileItem({
    super.key,
    required this.color,
    required this.label,
    required this.description,
    required this.onTap,
    required this.iconPath,
    this.size,
  });

  final String iconPath;
  final Color color;
  final String label;
  final String description;
  final void Function() onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: kPrimaryColor.withOpacity(0.02),
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  radius: 24,
                  child: SvgPicture.asset(
                    iconPath,
                    height: size ?? 20,
                  ),
                ),
                const Gap(width: 18),
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
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: kGrayColor.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.rotate(
              angle: math.pi / -2,
              child: IconButton(
                onPressed: onTap,
                color: kPrimaryColor,
                icon: SvgPicture.asset(
                  'lib/assets/icons/arrow-down.svg',
                  height: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
