import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
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

  static List<TransactionEntity> get untilDayIncomes {
    return allIncomes.where((tr) => tr.createAt.day <= DateTime.now().day).toList();
  }

  static double get untilDayIncomesValue {
    return (untilDayIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value)).roundToDouble();
  }
}
