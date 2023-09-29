// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cron/cron.dart';
import 'package:result_dart/result_dart.dart';

import 'package:elevo/src/infra/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/domain/enums/frequency_enum.dart';

class SchedulerTransaction {
  final ITransactionRepository repository;

  SchedulerTransaction({
    required this.repository,
  });

  var _cron = new Cron();

  void dailyTransactionSchedule() {
    _cron.schedule(new Schedule.parse("0 0 * * *"), () async {
      final result = repository.getTransactionsByProperty("frequency", Frequency.daily.name);
      result.fold((allTransactions) async {
        for (var transaction in allTransactions) {
          final oldDate = transaction.createAt;
          final updatedTransaction = transaction.copyWith(createAt: DateTime(oldDate.year, oldDate.month, oldDate.day + 1));
          await repository.createTransaction(updatedTransaction);
        }
      }, (error) => null);
    });
  }

  void monthlyTransactionSchedule() {
    _cron.schedule(new Schedule.parse("0 0 1 * *"), () async {
      final result = repository.getTransactionsByProperty("frequency", Frequency.monthly.name);
      result.fold((allTransactions) async {
        for (var transaction in allTransactions) {
          final oldDate = transaction.createAt;
          final updatedTransaction = transaction.copyWith(createAt: DateTime(oldDate.year, oldDate.month + 1, oldDate.day));
          await repository.createTransaction(updatedTransaction);
        }
      }, (error) => null);
    });
  }

  void yearlyTransactionSchedule() {
    _cron.schedule(new Schedule.parse("0 0 1 1 *"), () async {
      final result = repository.getTransactionsByProperty("frequency", Frequency.yearly.name);
      result.fold((allTransactions) async {
        for (var transaction in allTransactions) {
          final oldDate = transaction.createAt;
          final updatedTransaction = transaction.copyWith(createAt: DateTime(oldDate.year + 1, oldDate.month, oldDate.day));
          await repository.createTransaction(updatedTransaction);
        }
      }, (error) => null);
    });
  }
}
