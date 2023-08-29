import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/core/reducer/category_reducer.dart';
import 'package:elevo/src/core/reducer/input_reducer.dart';
import 'package:elevo/src/core/reducer/transaction_reducer.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  reducers;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const RxRoot(child: Elevo()),
  );
}

var uuid = const Uuid();

var reducers = [
  TransactionReducer(repository: SQLTransactionRepositoryImpl()),
  InputReducer(repository: SQLTransactionRepositoryImpl()),
  CategoryReducer(repository: LocalCategoryRepository()),
  WidthInsertAmountReducer(),
  SliderSelectTypeReducer(),
];
