// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:elevo/src/utils/constants.dart';

class ItemSlider extends StatelessWidget {
  const ItemSlider({
    Key? key,
    required this.isIncome,
    required this.label,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final bool isIncome;
  final String label;
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        height: 50,
        alignment: Alignment.center,
        width: (size.width - 40) / 2.2,
        decoration: BoxDecoration(
          color: isIncome ? (isIncome ? color.withOpacity(0.1) : Colors.transparent) : (isIncome ? color.withOpacity(0.1) : Colors.transparent),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: (isIncome ? color : kGrayColor),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
