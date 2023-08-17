import 'package:cron/cron.dart';
import 'package:elevo/core/enums/frequency_enum.dart';
import 'package:elevo/data/repositories/scheduled_transaction_repository.dart';
import 'package:elevo/data/repositories/transaction_repository.dart';
import 'package:result_dart/result_dart.dart';

class SchedulerLogic {
  SchedulerLogic({
    required this.scheduledTransactionRepository,
    required this.transactionRepository,
  });

  IScheduledTransactionRepository scheduledTransactionRepository;
  ITransactionRepository transactionRepository;

  final _cron = Cron();

  // Executes the daily transaction scheduler.
  void executeDailyTransactionScheduler() {
    _cron.schedule(Schedule.parse('0 0 * * * *'), () async {
      await scheduledTransactionRepository
          .findAllScheduledTransaction(Frequency.daily.frequency) //
          .fold((references) async {
        if (references.isEmpty) return;
        for (var ref in references) {
          final result = transactionRepository.getTransaction(ref.referenceId);

          result.fold((transaction) async {
            final updatedTransaction = transaction.copyWith(
              createAt: transaction.createAt.add(const Duration(days: 1)),
            );
            await transactionRepository.createTransaction(updatedTransaction);
          }, (_) => null);
        }
      }, (_) {});
    });
  }

  // Executes the monthly transaction scheduler.
  void executeMonthlyTransactionScheduler() {
    _cron.schedule(Schedule.parse('0 0 1 * * *'), () async {
      await scheduledTransactionRepository
          .findAllScheduledTransaction(Frequency.monthly.frequency) //
          .fold((references) async {
        if (references.isEmpty) return;
        for (var ref in references) {
          final result = await transactionRepository.getTransaction(ref.referenceId);
          result.fold((transaction) async {
            final date = transaction.createAt;
            // Computes the new date by adding 1 month to the transaction's date.
            final newDate = DateTime(date.year, date.month + 1, date.day);
            final updatedTransaction = transaction.copyWith(createAt: newDate);
            await transactionRepository.createTransaction(updatedTransaction);
          }, (_) {});
        }
      }, (_) {});
    });
  }

  // Executes the yearly transaction scheduler.
  void executeYearlyTransactionScheduler() {
    _cron.schedule(Schedule.parse('0 0 1 1 * *'), () async {
      await scheduledTransactionRepository
          .findAllScheduledTransaction(Frequency.yearly.frequency) //
          .fold((references) async {
        if (references.isEmpty) return;
        for (var ref in references) {
          final result = await transactionRepository.getTransaction(ref.referenceId);
          result.fold((transaction) async {
            final date = transaction.createAt;
            // Computes the new date by adding 1 month to the transaction's date.
            final newDate = DateTime(date.year, date.month + 1, date.day);
            final updatedTransaction = transaction.copyWith(createAt: newDate);
            await transactionRepository.createTransaction(updatedTransaction);
          }, (_) {});
        }
      }, (_) {});
    });
  }
}
