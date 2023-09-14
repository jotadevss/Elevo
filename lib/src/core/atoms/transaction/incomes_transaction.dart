import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

class IncomesTransactions {
  static List<TransactionEntity> get allIncomes {
    return transactions.where((tr) => tr.type == TypeTransaction.income.name).toList();
  }

  static double get totalIncomesValue {
    return (allIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }

  static List<TransactionEntity> get currentMonthIncomes {
    final currentMonth = DateTime.now().month;
    return allIncomes.where((tr) => tr.createAt.month == currentMonth).toList();
  }

  static double get totalCurrentMonthIncomesValue {
    return (currentMonthIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }
}
