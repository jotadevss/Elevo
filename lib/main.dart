import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/binds.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/scheduler.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  reducers;
  controllers;

  final scheduler = SchedulerTransaction(repository: SQLTransactionRepositoryImpl());
  scheduler.dailyTransactionSchedule();
  scheduler.monthlyTransactionSchedule();
  scheduler.yearlyTransactionSchedule();

  runApp(
    const RxRoot(child: Elevo()),
  );
}
