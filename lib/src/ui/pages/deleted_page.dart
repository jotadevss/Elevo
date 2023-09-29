// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/utils/constants.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:flutter/material.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class DeletedPage extends StatelessWidget {
  const DeletedPage({super.key, required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("lib/assets/animation/animation_lmvyxn2z.json", fit: BoxFit.cover, width: 120),
            //SvgPicture.asset('lib/assets/icons/trash.svg'),
            const Gap(height: 20),
            const Text(
              'Are you sure you want to\ndelete this item?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(height: 20),
            const Text(
              'Your transaction will be\npermanently deleted.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff929292),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(height: 26),
            ButtonWidget(
              iconAssetName: 'lib/assets/icons/trash.svg',
              title: 'Yes, permanent delete',
              color: kErrorColor,
              onTap: () {
                deleteTransactionAction.value = transaction.id;
                context.go(AppRouter.HOME_PAGE_ROUTER);
              },
            ),
            const Gap(height: 12),
            ButtonWidget(
              iconAssetName: null,
              title: 'Go back',
              color: kGrayColor,
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
