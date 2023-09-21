import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/router.dart';
import 'package:flutter/material.dart';

class Elevo extends StatefulWidget {
  const Elevo({super.key});

  @override
  State<Elevo> createState() => _ElevoState();
}

class _ElevoState extends State<Elevo> {
  @override
  void initState() {
    super.initState();

    // Watches for changes to the `isEmptyTransactionState` value.
    // When the value changes, the `effect` callback is executed.
    rxObserver(() => isEmptyTransactionState.value, effect: (value) {
      // If the `isEmptyTransactionState` value is true, navigate to the
      // `EMPTY_PAGE_ROUTER` route. Otherwise, navigate to the
      // `HOME_PAGE_ROUTER` route.
      if (value!) {
        router.go(AppRouter.EMPTY_PAGE_ROUTER);
      } else {
        router.go(AppRouter.HOME_PAGE_ROUTER);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: router,
    );
  }
}
