import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/dashboard_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/dashboard/components/pie_chart_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IncomesDashboardPage extends StatefulWidget {
  const IncomesDashboardPage({super.key});

  @override
  State<IncomesDashboardPage> createState() => _IncomesDashboardPageState();
}

class _IncomesDashboardPageState extends State<IncomesDashboardPage> {
  @override
  void initState() {
    loadIncomesDashboardAction.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    final sections = context.select(() => incomesSectionsAtom.value);
    final dtos = context.select(() => incomesDtoAtom.value);
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
                    const Gap(height: 24),
                    PieChartDashboardWidget(
                      icon: const Icon(Icons.trending_up_rounded, color: kPrimaryColor),
                      colorIcon: null,
                      svgPath: null,
                      sections: sections,
                      dtos: dtos,
                      value: IncomesTransactions.totalCurrentMonthIncomesValue,
                    ),
                    const Gap(height: 32),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(99),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(color: kGrayColor.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Gap(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Incomes Added',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      'Recent trasactions',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: kPrimaryColor.withOpacity(0.1),
                              radius: 26,
                              child: Text(
                                IncomesTransactions.allIncomes.length.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(height: 64),
                  ],
                ),
              ),
            ),
    );
  }
}
