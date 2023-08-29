import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/ui/pages/deleted_page.dart';
import 'package:elevo/src/ui/pages/empty_page.dart';
import 'package:elevo/src/ui/pages/home/home_page.dart';
import 'package:elevo/src/ui/pages/input/input_page.dart';
import 'package:elevo/src/ui/pages/splash_page.dart';
import 'package:elevo/src/ui/pages/input_success_page.dart';
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
        return InputPage();
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
        return InputSuccessPage();
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
