import 'package:elevo/src/core/dto/category_props_dto.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:elevo/src/ui/pages/dashboard/expenses_dashboard_page.dart';
import 'package:elevo/src/ui/pages/dashboard/incomes_dashboard_page.dart';
import 'package:elevo/src/ui/pages/deleted_page.dart';
import 'package:elevo/src/ui/pages/empty_page.dart';
import 'package:elevo/src/ui/pages/historic/historic_detail_page.dart';
import 'package:elevo/src/ui/pages/historic/historic_page.dart';
import 'package:elevo/src/ui/pages/home/home_page.dart';
import 'package:elevo/src/ui/pages/input/input_page.dart';
import 'package:elevo/src/ui/pages/splash_page.dart';
import 'package:elevo/src/ui/pages/input/input_success_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRouter.SPLASH_PAGE_ROUTER,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: AppRouter.HOME_PAGE_ROUTER,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: AppRouter.EMPTY_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const EmptyPage());
      },
    ),
    GoRoute(
      path: AppRouter.DELETED_PAGE_ROUTER,
      pageBuilder: (context, state) {
        final transactionArgs = state.extra as TransactionEntity;
        return buildSlideTransaction(const Offset(1, 0), DeletedPage(transaction: transactionArgs));
      },
    ),
    GoRoute(
      path: AppRouter.INPUT_SUCCESS_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const InputSuccessPage());
      },
    ),
    GoRoute(
      path: AppRouter.INPUT_DATA_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(0, 1), const InputPage());
      },
    ),
    GoRoute(
      path: AppRouter.HISTORIC_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const HistoricPage());
      },
    ),
    GoRoute(
      path: AppRouter.DASHBOARD_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const DashboardPage());
      },
    ),
    GoRoute(
      path: AppRouter.INCOMES_DASHBOARD_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const IncomesDashboardPage());
      },
    ),
    GoRoute(
      path: AppRouter.EXPENSES_DASHBOARD_PAGE_ROUTER,
      pageBuilder: (context, state) {
        return buildSlideTransaction(const Offset(1, 0), const ExpensesDashboardPage());
      },
    ),
    GoRoute(
      path: AppRouter.HISTORIC_DETAIL_PAGE_ROUTER,
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return CustomTransitionPage(
          child: HistoricDetailPage(
            transaction: args['transaction'] as TransactionEntity,
            categoryProps: args['categoryProps'] as CategoryProsDTO,
          ),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

CustomTransitionPage<dynamic> buildSlideTransaction(Offset begin, Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

class AppRouter {
  static const String SPLASH_PAGE_ROUTER = '/';
  static const String EMPTY_PAGE_ROUTER = '/empty';
  static const String HOME_PAGE_ROUTER = '/home';
  static const String DELETED_PAGE_ROUTER = '/deleted';
  static const String ERROR_PAGE_ROUTER = '/error';
  static const String INPUT_DATA_PAGE_ROUTER = '/input-data';
  static const String INPUT_SUCCESS_PAGE_ROUTER = '/input-success';
  static const String HISTORIC_PAGE_ROUTER = '/historic';
  static const String HISTORIC_DETAIL_PAGE_ROUTER = '/historic-detail';
  static const String DASHBOARD_PAGE_ROUTER = '/dashboard';
  static const String INCOMES_DASHBOARD_PAGE_ROUTER = '/dashboard-incomes';
  static const String EXPENSES_DASHBOARD_PAGE_ROUTER = '/dashboard-expenses';
}
