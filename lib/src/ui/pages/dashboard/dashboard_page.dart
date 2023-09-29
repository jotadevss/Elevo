import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/dashboard_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/dashboard/components/card_navigator_dashboard_widget.dart';
import 'package:elevo/src/ui/pages/dashboard/components/pie_chart_dashboard_widget.dart';
import 'package:elevo/src/ui/pages/historic/components/header_transaction_info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    loadOverviewDashboardAction.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    final sections = context.select(() => overviewSectionsAtom.value);
    final dtos = context.select(() => overviewDtoAtom.value);
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
                    const Gap(height: 12),
                    const HeaderTransactionInfo(),
                    const Gap(height: 24),
                    PieChartDashboardWidget(
                      label: "Overview",
                      svgPath: 'lib/assets/icons/wallet-money.svg',
                      colorIcon: kPrimaryColor,
                      description: "Total Balance",
                      icon: null,
                      dtos: dtos,
                      value: totalBalance,
                      dashboard: PieChart(PieChartData(
                        sections: sections,
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            if (!event.isInterestedForInteractions && response == null && response?.touchedSection == null) {
                              touchIndexOverviewAction.value = -1;
                              return;
                            }
                            touchIndexOverviewAction.value = response!.touchedSection!.touchedSectionIndex;
                          },
                        ),
                      )),
                    ),
                    const Gap(height: 44),
                    const Row(
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
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        controller: new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        crossAxisSpacing: 12,
                        children: [
                          CardNavigatorDashboardWidget(
                            label: "Incomes",
                            icon: const Icon(
                              Icons.trending_up_rounded,
                              color: kPrimaryColor,
                            ),
                            func: () {
                              router.push(AppRouter.INCOMES_DASHBOARD_PAGE_ROUTER);
                            },
                          ),
                          CardNavigatorDashboardWidget(
                            label: "Expenses",
                            icon: const Icon(
                              Icons.trending_down_rounded,
                              color: kErrorColor,
                            ),
                            func: () {
                              router.push(AppRouter.EXPENSES_DASHBOARD_PAGE_ROUTER);
                            },
                          ),
                        ],
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
