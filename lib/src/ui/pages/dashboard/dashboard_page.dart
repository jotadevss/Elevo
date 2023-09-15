import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/dashboard_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/dashboard/components/indicator_item_widget.dart';
import 'package:elevo/src/ui/pages/historic/components/header_transaction_info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    loadDashboardAction.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    final sections = context.select(() => overviewSectionsAtom.value);
    final dtos = context.select(() => overviewDtoAtom.value);
    return (isLoading)
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : Scaffold(
            body: SingleChildScrollView(
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
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kGrayColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Overview',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: kGrayColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text(
                                  'This Month',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kGrayColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(height: 24),
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    sections: sections,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'lib/assets/icons/wallet-money.svg',
                                      height: 28,
                                    ),
                                    Text(
                                      '\$' + CurrencyFormatter.format(totalTransactionsValue.toString()),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Total added',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kGrayColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Gap(height: 12),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Gap(height: 36),
                          IndicatorItem(
                            label: 'Incomes',
                            value: IncomesTransactions.totalCurrentMonthIncomesValue,
                            percent: dtos[0].percent,
                            color: kPrimaryColor,
                          ),
                          Gap(height: 12),
                          IndicatorItem(
                            label: 'Expense',
                            value: ExpensesTransactions.totalCurrentMonthExpensesValue,
                            percent: dtos[1].percent,
                            color: kSecondaryColor,
                          ),
                          Gap(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
