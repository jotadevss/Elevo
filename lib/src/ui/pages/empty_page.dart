// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:elevo/src/constants.dart';
import 'package:go_router/go_router.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/icons/empty-wallet.svg'),
            const Gap(height: 20),
            const Text(
              'No transaction\nregistered!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(height: 20),
            const Text(
              'Add your first transaction and\nstart managing your finances',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff929292),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(height: 25),
            ButtonWidget(
              iconAssetName: 'lib/assets/icons/wallet-money.svg',
              title: 'Add transaction',
              color: kPrimaryColor,
              onTap: () {
                context.push(AppRouter.INPUT_DATA_PAGE_ROUTER);
              },
            ),
          ],
        ),
      ),
    );
  }
}
