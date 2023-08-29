import 'package:elevo/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: kGrayColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: SvgPicture.asset('lib/assets/icons/close.svg'),
        ),
      ),
    );
  }
}
