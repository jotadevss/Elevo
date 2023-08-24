import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/dto/summary_transaction_dto.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final listTransactionAtom = Atom(<TransactionEntity>[]);
final selectedTransaction = Atom<TransactionEntity?>(null);

// Getters
List<TransactionEntity> get transactions {
  if (listTransactionAtom.value.isNotEmpty) {
    isFirstRunAppState.value = false;
    return [...listTransactionAtom.value];
  } else {
    isFirstRunAppState.value = true;
    return [];
  }
}

int get totalTransactions => transactions.length;

TransactionSummaryDTO get allIncomes {
  final listOfAllIncomes = transactions.where((tr) => tr.type == TypeTransaction.incomes.name).toList();
  final totalSumIncomes = listOfAllIncomes.fold(0.0, (previousValue, transaction) => previousValue + transaction.value);
  return TransactionSummaryDTO(totalAmount: totalSumIncomes, transactions: listOfAllIncomes);
}

TransactionSummaryDTO get allExpenses {
  final listOfAllExpenses = transactions.where((tr) => tr.type == TypeTransaction.expense.name).toList();
  final totalSumExpenses = listOfAllExpenses.fold(0.0, (previousValue, transaction) => previousValue + transaction.value);
  return TransactionSummaryDTO(totalAmount: totalSumExpenses, transactions: listOfAllExpenses);
}

double get totalBalance => allIncomes.totalAmount - allExpenses.totalAmount;

TransactionSummaryDTO get filtedByActualMonth {
  final actualMonth = DateTime.now().month;
  final filted = transactions.where((tr) => tr.createAt.month == actualMonth).toList();
  final totalAmount = filted.fold(0.0, (previousValue, transaction) => previousValue + transaction.value);
  return TransactionSummaryDTO(totalAmount: totalAmount, transactions: filted);
}

// Actions
final getAllTransactionAction = Atom.action();
final getByIdTransactionAction = Atom<String?>(null);
final deleteTransactionAction = Atom<String?>(null);
