// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elevo/src/ui/common/components/gap.dart';

class DeletedPage extends StatelessWidget {
  const DeletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/icons/trash.svg'),
            Gap(height: 20),
            Text(
              'Transaction deleted!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(height: 20),
            Text(
              'Your transaction has been\npermanently deleted.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff929292),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(height: 25),
            ButtonWidget(
              iconAssetName: 'lib/assets/icons/home.svg',
              title: 'Back to Home',
              color: kPrimaryColor,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
