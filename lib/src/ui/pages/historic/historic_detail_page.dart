import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/core/dto/category_props_dto.dart';
import 'package:elevo/src/core/formatters/date_formatter.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/button.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/formatters/currency_formatter.dart';

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
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
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
                    Gap(height: 32),
                    CircleAvatar(
                      backgroundColor:
                          (TypeTransaction.income.name == transaction.type) ? kPrimaryColor.withOpacity(0.1) : kErrorColor.withOpacity(0.1),
                      radius: 32,
                      child: SvgPicture.asset(
                        categoryProps.iconPath,
                      ),
                    ),
                    Gap(height: 16),
                    Text(
                      categoryProps.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(height: 32),
                    Container(
                      padding: EdgeInsets.all(32),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: kGrayColor.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categoryProps.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\$' + CurrencyFormatter.format(transaction.value.toString()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: (TypeTransaction.income.name == transaction.type) ? kPrimaryColor : kErrorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Gap(height: 32),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction ID',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(height: 6),
                              Text(
                                transaction.id,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kGrayColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(
                              color: kGrayColor.withOpacity(0.1),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Creation Date',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(height: 6),
                                  Text(
                                    DateFormatter.format(transaction.createAt),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kGrayColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(width: size.width / 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Frequency',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(height: 6),
                                  Text(
                                    transaction.type,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kGrayColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(
                              color: kGrayColor.withOpacity(0.1),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(height: 6),
                                  Text(
                                    transaction.description ?? 'No Description',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kGrayColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(height: 32),
                    ButtonWidget(
                      iconAssetName: 'lib/assets/icons/trash.svg',
                      title: 'Delete transaction',
                      color: kErrorColor,
                      onTap: () {
                        deleteTransactionAction.value = transaction.id;
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
