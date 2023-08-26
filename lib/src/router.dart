import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/ui/pages/deleted/deleted_page.dart';
import 'package:elevo/src/ui/pages/empty/empty_page.dart';
import 'package:elevo/src/ui/pages/home/home_page.dart';
import 'package:elevo/src/ui/pages/splash/splash_page.dart';
import 'package:elevo/src/ui/pages/success/success_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) {
    if (isEmptyTransactionState.value) {
      return AppRouter.EMPTY_PAGE_ROUTER;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRouter.SPLASH_PAGE_ROUTER,
      builder: (context, state) {
        return SplashPage();
      },
    ),
    GoRoute(
      path: AppRouter.HOME_PAGE_ROUTER,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: AppRouter.EMPTY_PAGE_ROUTER,
      builder: (context, state) {
        return EmptyPage();
      },
    ),
    GoRoute(
      path: AppRouter.DELETED_PAGE_ROUTER,
      builder: (context, state) {
        return DeletedPage();
      },
    ),
    GoRoute(
      path: AppRouter.INPUT_SUCCESS_PAGE_ROUTER,
      builder: (context, state) {
        return SuccessPage();
      },
    ),
  ],
);

class AppRouter {
  static const String SPLASH_PAGE_ROUTER = '/';
  static const String EMPTY_PAGE_ROUTER = '/empty';
  static const String HOME_PAGE_ROUTER = '/home';
  static const String DELETED_PAGE_ROUTER = '/deleted';
  static const String ERROR_PAGE_ROUTER = '/error';
  static const String INPUT_SUCCESS_PAGE_ROUTER = '/input-success';
}
