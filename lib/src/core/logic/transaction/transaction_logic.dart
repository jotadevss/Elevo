// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:flutter/widgets.dart';

final cacheTransaction = Atom(<TransactionEntity>[]);
final selectedTransactionAtom = Atom<TransactionEntity?>(null);
final isEmptyTransactionState = Atom<bool>(false);

// Getters
List<TransactionEntity> get transactions => [...cacheTransaction.value];

int get totalTransactions => transactions.length;

double get totalTransactionsValue {
  return transactions.fold(0.0, (previousValue, transaction) => previousValue + transaction.value).roundToDouble();
}

double get totalBalance => (IncomesTransactions.untilDayIncomesValue - ExpensesTransactions.untilDayExpensesValue).roundToDouble();

bool get isNegative => totalBalance < 0;

// Actions
final getAllTransactionAction = Atom.action();
final getByIdTransactionAction = Atom<String?>(null);
final deleteTransactionAction = Atom<String?>(null);

class TransactionReducer extends Reducer {
  final ITransactionRepository repository;

  TransactionReducer({required this.repository}) {
    on(() => [getAllTransactionAction], getAll);
    on(() => [getByIdTransactionAction], getById);
    on(() => [deleteTransactionAction], delete);
  }

  Future<void> getAll() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      isLoadingState.value = true;
    });

    final result = await repository.getAllTransactions();

    result.fold(
      (transactions) {
        cacheTransaction.value.clear();
        cacheTransaction.value = transactions;
      },
      (error) {},
    );

    checkTransactionStatus();

    isLoadingState.value = false;
  }

  Future<void> getById() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      isLoadingState.value = true;
    });

    final id = getByIdTransactionAction.value!;
    final result = await repository.getTransaction(id);

    result.fold(
      (transaction) {
        final index = cacheTransaction.value.indexWhere((tr) => tr.id == id);
        cacheTransaction.value.removeAt(index);
        selectedTransactionAtom.value = transaction;
      },
      (error) {},
    );

    isLoadingState.value = false;
  }

  Future<void> delete() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      isLoadingState.value = true;
    });

    final id = deleteTransactionAction.value!;
    final index = cacheTransaction.value.indexWhere((tr) => tr.id == id);
    final saved = cacheTransaction.value[index];

    cacheTransaction.value.removeAt(index);

    final result = await repository.deleteTransaction(id);
    result.fold(
      (_) {
        checkTransactionStatus();
      },
      (error) {
        cacheTransaction.value[index] = saved;
      },
    );

    isLoadingState.value = false;
  }

  void checkTransactionStatus() {
    if (transactions.length <= 0) {
      isEmptyTransactionState.value = true;
    } else {
      isEmptyTransactionState.value = false;
    }
  }
}
