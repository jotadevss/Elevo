import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({
    Key? key,
    this.height = 8,
    this.width = 8,
  }) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
