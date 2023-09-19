import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Class representing expenses transactions.
class ExpensesTransactions {
  // Returns a list of all expenses transactions.
  static List<TransactionEntity> get allExpenses {
    // Filters the list of all transactions to only include expenses transactions.
    return transactions.where((tr) => tr.type == TypeTransaction.expense.name).toList();
  }

  // Returns the total value of all expenses transactions.
  static double get totalExpensesValue {
    // Calculates the total value of all expenses transactions using the `fold()` method.
    return (allExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  // Returns a list of all expenses transactions for the current month.
  static List<TransactionEntity> get currentMonthExpenses {
    // Gets the current month.
    final currentMonth = DateTime.now().month;
    // Filters the list of all expenses transactions to only include transactions for the current month.
    return allExpenses.where((tr) => tr.createAt.month == currentMonth).toList();
  }

  // Returns the total value of all expenses transactions for the current month.
  static double get totalCurrentMonthExpensesValue {
    // Calculates the total value of all expenses transactions for the current month using the `fold()` method.
    return (currentMonthExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  // Returns a list of all expenses transactions up to the current day.
  static List<TransactionEntity> get untilDayExpenses {
    // Filters the list of all expenses transactions to only include transactions up to the current day.
    return allExpenses.where((tr) => tr.createAt.day <= DateTime.now().day).toList();
  }

  // Returns the total value of all expenses transactions up to the current day.
  static double get untilDayExpensesValue {
    // Calculates the total value of all expenses transactions up to the current day using the `fold()` method.
    return (untilDayExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }
}
