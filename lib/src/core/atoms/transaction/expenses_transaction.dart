import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

class ExpensesTransactions {
  static List<TransactionEntity> get allExpenses {
    return transactions.where((tr) => tr.type == TypeTransaction.expense.name).toList();
  }

  static double get totalExpensesValue {
    return (allExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  static List<TransactionEntity> get currentMonthExpenses {
    final currentMonth = DateTime.now().month;
    return allExpenses.where((tr) => tr.createAt.month == currentMonth).toList();
  }

  static double get totalCurrentMonthExpensesValue {
    return (currentMonthExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }
}
