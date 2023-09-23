import 'package:elevo/src/constants.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class InputSuccessPage extends StatelessWidget {
  const InputSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("lib/assets/animation/animation_lmvyx38b.json", repeat: false, height: 128),
            const Gap(height: 20),
            const Text(
              'Transaction added\nsuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(height: 20),
            const Text(
              'Your transaction was successfully added,\nto access it, just access the history.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff929292),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(height: 25),
            ButtonWidget(
              iconAssetName: null,
              title: '  Go to Home  ',
              color: kGrayColor,
              onTap: () {
                context.replace(AppRouter.HOME_PAGE_ROUTER);
              },
            ),
          ],
        ),
      ),
    );
  }
}
