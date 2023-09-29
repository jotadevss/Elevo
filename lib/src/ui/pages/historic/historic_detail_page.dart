import 'package:asp/asp.dart';
import 'package:elevo/src/utils/constants.dart';
import 'package:elevo/src/core/dto/category_props_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/historic/components/card_transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HistoricDetailPage extends StatelessWidget {
  const HistoricDetailPage({super.key, required this.transaction, required this.categoryProps});

  final TransactionEntity transaction;
  final CategoryProsDTO categoryProps;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = context.select(() => isLoadingState.value);
    return Scaffold(
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: getStatusBar(context) + 10, left: kMarginHorizontal + 4, right: kMarginHorizontal + 4),
                child: Column(
                  children: [
                    ElevoAppBar(
                      enableAction: true,
                      isCenter: false,
                      assetName: 'lib/assets/icons/arrow-left.svg',
                      action: () {
                        context.pop();
                      },
                    ),
                    const Gap(height: 32),
                    CircleAvatar(
                      backgroundColor:
                          (TypeTransaction.income.name == transaction.type) ? kPrimaryColor.withOpacity(0.1) : kSecondaryColor.withOpacity(0.1),
                      radius: 32,
                      child: SvgPicture.asset(
                        categoryProps.iconPath,
                        colorFilter:
                            ColorFilter.mode((TypeTransaction.income.name == transaction.type) ? kPrimaryColor : kSecondaryColor, BlendMode.srcIn),
                      ),
                    ),
                    const Gap(height: 16),
                    Text(
                      categoryProps.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(height: 32),
                    CardTransactionDetails(categoryProps: categoryProps, transaction: transaction, size: size),
                    const Gap(height: 32),
                    ButtonWidget(
                      iconAssetName: 'lib/assets/icons/trash.svg',
                      title: 'Delete transaction',
                      color: kErrorColor,
                      onTap: () {
                        context.push(AppRouter.DELETED_PAGE_ROUTER, extra: transaction);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
