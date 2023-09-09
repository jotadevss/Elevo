import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/category_atom.dart';
import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/core/formatters/date_formatter.dart';
import 'package:elevo/src/core/usecase/refresh_transaction_usecase.dart';
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
    final isLoading = context.select(() => isLoadingState.value);
    final listOfAllTransactions = context.select(() => transactions);

    return (isLoading)
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : Scaffold(
            body: RefreshIndicator.adaptive(
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
                    HeaderTransactionInfo(),
                    const Gap(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: totalTransactions,
                        itemBuilder: (context, index) {
                          final item = listOfAllTransactions.reversed.toList()[index];

                          final category = categories.where((ct) {
                            return ct.id == item.category;
                          }).toList();

                          final label = category[0].title;
                          final iconPath = category[0].iconPath;
                          final transactionDate = DateFormatter.format(item.createAt);
                          final fixedTransaction = item.frequency ?? 'unique';
                          final value = item.value;
                          return TransactionCardItem(
                            iconPath: iconPath,
                            label: label,
                            item: item,
                            value: value,
                            transactionDate: transactionDate,
                            fixedTransaction: fixedTransaction,
                            onTap: () {},
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
