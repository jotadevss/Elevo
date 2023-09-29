import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:elevo/src/core/logic/category_logic.dart';
import 'package:elevo/src/core/logic/dashboard_logic.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/infra/repositories/local_category_repository.dart';
import 'package:elevo/src/infra/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/infra/services/auth/firebase_auth_service.dart';
import 'package:elevo/src/infra/services/auth/local_auth_biometrics_service.dart';
import 'package:elevo/src/ui/pages/home/controller/toggle_visibility_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/date_picker_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';

// Reducers
var reducers = [
  TransactionLogic(repository: SQLTransactionRepositoryImpl()),
  InputLogic(repository: SQLTransactionRepositoryImpl()),
  CategoryLogic(repository: LocalCategoryRepository()),
  AuthLogic(FirebaseAuthService(), LocalAuthBiometricsService()),
  DashboardLogic(),
  AppLogic(),
];

// Controllers
var controllers = [
  DatePickerController(),
  ToggleSwitchIsFixedController(),
  SliderSelectTypeController(),
  WidthInsertAmountController(),
  ToggleVisibilityController(),
];
