import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:elevo/src/utils/constants.dart';
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

    rxObserver(() => [isAuthenticatedAtom.value, isEmptyTransactionState.value, isFirstTimeInAppState.value], effect: (states) {
      final [authState as AuthState, transactionState as bool, isFirstTimeInApp as bool] = states!;
      if (authState == AuthState.logged) {
        (transactionState) ? router.go(AppRouter.EMPTY_PAGE_ROUTER) : router.go(AppRouter.HOME_PAGE_ROUTER);
      } else {
        (isFirstTimeInApp) ? router.go(AppRouter.AUTH_REGISTER_PAGE_ROUTER) : router.go(AppRouter.AUTH_SIGN_IN_PAGE_ROUTER);
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
