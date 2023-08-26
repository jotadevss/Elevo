import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/reducer/input_reducer.dart';
import 'package:elevo/src/core/reducer/transaction_reducer.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/router.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

var reducers = [
  TransactionReducer(repository: SQLTransactionRepositoryImpl()),
  InputReducer(repository: SQLTransactionRepositoryImpl()),
];

void main() async {
  reducers;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const RxRoot(child: Elevo()),
  );
}
