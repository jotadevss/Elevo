import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/core/logic/refresh_transaction_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/custom_tile_item.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/home/components/wallet_status_card_item_widget.dart';
import 'package:elevo/src/ui/pages/home/controller/toggle_visibility_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'components/home_card_total_balance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getAllTransactionAction.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final isVisible = context.select(() => isVisibleAtom.value);
    final balance = context.select(() => totalBalance);
    final isLoading = context.select(() => isLoadingState.value);

    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await refresh.call();
        },
        color: kSecondaryColor,
        child: (isLoading)
            ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: getStatusBar(context) + 10, left: kMarginHorizontal + 8, right: kMarginHorizontal + 8),
                  child: Column(
                    children: [
                      ElevoAppBar(enableAction: false, isCenter: true),
                      Gap(height: 32),
                      CardTotalBalance(
                        isVisible: isVisible,
                        value: balance,
                        onTap: () {
                          context.push(AppRouter.INPUT_DATA_PAGE_ROUTER);
                        },
                      ),
                      Gap(height: 32),
                      CustomTileItem(
                        iconPath: 'lib/assets/icons/bill.svg',
                        label: "Historic",
                        description: "Access all registered transactions",
                        color: kPrimaryColor,
                        onTap: () {
                          context.push(AppRouter.HISTORIC_PAGE_ROUTER);
                        },
                      ),
                      Gap(height: 12),
                      CustomTileItem(
                        iconPath: 'lib/assets/icons/chart.svg',
                        label: "Dashboard",
                        description: "Check graphs for your analysis",
                        color: kPrimaryColor,
                        onTap: () {
                          context.push(AppRouter.DASHBOARD_PAGE_ROUTER);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Divider(color: kGrayColor.withOpacity(0.1)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Wallet',
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
                          )
                        ],
                      ),
                      Gap(height: 12),
                      SizedBox(
                        height: 280,
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          controller: new ScrollController(keepScrollOffset: false),
                          childAspectRatio: (itemWidth / itemHeight) + (itemWidth / itemHeight) / 1.5,
                          crossAxisSpacing: 12,
                          shrinkWrap: false,
                          children: [
                            WalletStatusCardItemWidget(
                              isVisible: isVisible,
                              color: kPrimaryColor,
                              label: 'Incomes',
                              value: IncomesTransactions.totalCurrentMonthIncomesValue,
                              icon: Icon(
                                Icons.trending_up_rounded,
                                size: 20,
                                color: kPrimaryColor,
                              ),
                            ),
                            WalletStatusCardItemWidget(
                              isVisible: isVisible,
                              color: kErrorColor,
                              label: 'Expenses',
                              value: ExpensesTransactions.totalCurrentMonthExpensesValue,
                              icon: Icon(
                                Icons.trending_down_rounded,
                                size: 20,
                                color: kErrorColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(height: 32),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
