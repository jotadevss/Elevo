import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/config.dart';
import 'package:elevo/src/infra/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/utils/scheduler.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeConfigurations();

  final scheduler = SchedulerTransaction(repository: SQLTransactionRepositoryImpl());
  scheduler.dailyTransactionSchedule();
  scheduler.monthlyTransactionSchedule();
  scheduler.yearlyTransactionSchedule();

  runApp(
    const RxRoot(child: Elevo()),
  );
}
