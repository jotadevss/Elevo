import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Class representing income transactions.
class IncomesTransactions {
  // Returns a list of all income transactions.
  static List<TransactionEntity> get allIncomes {
    // Filters the list of all transactions to only include income transactions.
    return transactions.where((tr) => tr.type == TypeTransaction.income.name).toList();
  }

  // Returns the total value of all income transactions.
  static double get totalIncomesValue {
    // Calculates the total value of all income transactions using the `fold()` method.
    return (allIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  // Returns a list of all income transactions for the current month.
  static List<TransactionEntity> get currentMonthIncomes {
    // Gets the current month.
    final currentMonth = DateTime.now().month;
    // Filters the list of all income transactions to only include transactions for the current month.
    return allIncomes.where((tr) => tr.createAt.month == currentMonth).toList();
  }

  // Returns the total value of all income transactions for the current month.
  static double get totalCurrentMonthIncomesValue {
    // Calculates the total value of all income transactions for the current month using the `fold()` method.
    return (currentMonthIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  // Returns a list of all income transactions up to the current day.
  static List<TransactionEntity> get untilDayIncomes {
    // Filters the list of all income transactions to only include transactions up to the current day.
    return allIncomes.where((tr) => tr.createAt.day <= DateTime.now().day).toList();
  }

  // Returns the total value of all income transactions up to the current day.
  static double get untilDayIncomesValue {
    // Calculates the total value of all income transactions up to the current day using the `fold()` method.
    return (untilDayIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }
}
