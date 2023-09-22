import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/category_logic.dart';
import 'package:elevo/src/core/dto/category_props_dto.dart';
import 'package:elevo/src/core/formatters/date_formatter.dart';
import 'package:elevo/src/core/logic/refresh_transaction_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/historic/components/header_transaction_info.dart';
import 'package:elevo/src/ui/pages/historic/components/transaction_card_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  @override
  void initState() {
    loadAllCategoriesAction.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = context.select(() => isLoadingState.value);
    final listOfAllTransactions = context.select(() => transactions);
    final listOfAllCategories = context.select(() => getAllCategories);
    log(size.height.toString());

    return Scaffold(
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : RefreshIndicator.adaptive(
              onRefresh: () async {
                await refresh.call();
              },
              color: kSecondaryColor,
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
                    const Gap(height: 12),
                    const HeaderTransactionInfo(),
                    const Gap(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listOfAllTransactions.length,
                        itemExtent: size.height / 3.8,
                        itemBuilder: (context, index) {
                          final item = listOfAllTransactions.reversed.toList()[index];

                          final List<CategoryEntity?> category = listOfAllCategories.where((ct) {
                            return ct.id == item.category;
                          }).toList();

                          final String? label = (category.isEmpty) ? "" : category[0]?.title;
                          final String? iconPath = (category.isEmpty) ? "" : category[0]?.iconPath;
                          final props = CategoryProsDTO(label: label ?? '', iconPath: iconPath ?? '');

                          final transactionDate = DateFormatter.format(item.createAt);
                          final fixedTransaction = item.frequency ?? 'unique';
                          final value = item.value;

                          return TransactionCardItem(
                            key: Key(item.id),
                            iconPath: iconPath ?? '',
                            label: label ?? '',
                            item: item,
                            value: value,
                            transactionDate: transactionDate,
                            fixedTransaction: fixedTransaction,
                            onTap: () {
                              context.push(
                                AppRouter.HISTORIC_DETAIL_PAGE_ROUTER,
                                extra: {'transaction': item, 'categoryProps': props},
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
