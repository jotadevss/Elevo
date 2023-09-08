import 'package:elevo/src/core/reducer/category_reducer.dart';
import 'package:elevo/src/core/reducer/input_reducer.dart';
import 'package:elevo/src/core/reducer/transaction_reducer.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/ui/pages/home/controller/toggle_visibility_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/date_picker_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';

// Reducers
var reducers = [
  TransactionReducer(repository: SQLTransactionRepositoryImpl()),
  InputReducer(repository: SQLTransactionRepositoryImpl()),
  CategoryReducer(repository: LocalCategoryRepository()),
];

// Controllers
var controllers = [
  DatePickerController(),
  ToggleSwitchIsFixedController(),
  SliderSelectTypeController(),
  WidthInsertAmountController(),
  ToggleVisibilityController(),
];
