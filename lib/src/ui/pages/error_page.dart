import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/icons/forbidden-2.svg'),
            Gap(height: 20),
            Text(
              'Oops! An error has\noccurred...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(height: 20),
            Text(
              'An unknown error occurred\nplease try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff929292),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(height: 25),
            ButtonWidget(
              iconAssetName: 'lib/assets/icons/refresh-2.svg',
              title: 'Try Again',
              color: kPrimaryColor,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
