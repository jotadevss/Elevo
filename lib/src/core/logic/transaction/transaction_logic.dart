// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/domain/entity/transaction.dart';

// Atoms
final cacheTransaction = Atom(<TransactionEntity>[]);
final selectedTransactionAtom = Atom<TransactionEntity?>(null);
final isEmptyTransactionState = Atom<bool>(false);

// Getters
List<TransactionEntity> get transactions {
  /// creates a clone of the list [cacheTransaction]
  final clone = [...cacheTransaction.value];
  return clone;
}

int get totalTransactions {
  /// Return the length of the list [cacheTransaction]
  return transactions.length;
}

double get totalTransactionsValue {
  // adds all transactions already added
  return transactions //
      .fold(0.0, (previousValue, transaction) {
    return previousValue + transaction.value;
  }).roundToDouble();
}

double get totalBalance {
  // returns the total balance
  final incomes = IncomesTransactions.untilDayIncomesValue;
  final expenses = ExpensesTransactions.untilDayExpensesValue;
  return (incomes - expenses).roundToDouble();
}

bool get isNegative {
  // checks if the total balance is negative
  return totalBalance < 0;
}

// Actions
final getAllTransactionAction = Atom.action();
final getByIdTransactionAction = Atom<String?>(null);
final deleteTransactionAction = Atom<String?>(null);

class TransactionLogic extends Reducer {
  final ITransactionRepository repository;

  TransactionLogic({required this.repository}) {
    // Handle Actions
    on(() => [getAllTransactionAction], getAll);
    on(() => [getByIdTransactionAction], getById);
    on(() => [deleteTransactionAction], delete);
  }

  // This function loads all added transactions
  Future<void> getAll() async {
    /// Start the loading state [isLoadingState]
    startLoadingAction.call();

    // Requesting the transaction by repository and handle the data from result...
    final result = await repository.getAllTransactions();
    result.fold(
      (transactions) {
        // If everything goes well, the data is stored in the cache
        cacheTransaction.value.clear(); // clear the cache and...
        cacheTransaction.value = transactions; // ...then add the updated list
        // this is used to avoid duplication
      },
      (error) {},
    );

    // checks the status of the app, where it checks whether
    // the app has empty data or not
    checkTransactionStatus();

    /// Stop the loading state [isLoadingState]
    stopLoadingAction.call();
  }

  Future<void> getById() async {
    /// Start the loading state [isLoadingState]
    startLoadingAction.call();

    // get the transaction id
    final id = getByIdTransactionAction.value!;

    // Requesting the transaction by id by repository and handle the data from result...
    final result = await repository.getTransaction(id);
    result.fold(
      (transaction) {
        // Takes the transaction id and looks for which index it is located
        // and then deletes it from cache storage to replace to replace with the updated
        // this is used to avoid duplication
        final index = cacheTransaction.value.indexWhere((tr) => tr.id == id);
        cacheTransaction.value.removeAt(index);
        selectedTransactionAtom.value = transaction;
      },
      (error) {},
    );

    /// Start the loading state [isLoadingState]
    stopLoadingAction.call();
  }

  Future<void> delete() async {
    /// Start the loading state [isLoadingState]
    startLoadingAction.call();

    // Takes the transaction id and looks for which index it is located
    // and then deletes it from cache storage
    final id = deleteTransactionAction.value!;
    final index = cacheTransaction.value.indexWhere((tr) => tr.id == id);
    final saved = cacheTransaction.value[index];
    cacheTransaction.value.removeAt(index);

    // Requesting the delete transaction by id by repository and handle the data from result...
    final result = await repository.deleteTransaction(id);
    result.fold(
      (_) {
        // checks the status of the app, where it checks whether
        // the app has empty data or not
        checkTransactionStatus();
      },
      (error) {
        // In case of error, the data that was deleted from
        // the cache will be reallocated again
        cacheTransaction.value[index] = saved;
      },
    );

    /// Stop the loading state [isLoadingState]
    stopLoadingAction.call();
  }

  void checkTransactionStatus() {
    // checks the status of the app, where it checks whether
    // the app has empty data or not
    if (transactions.length <= 0) {
      isEmptyTransactionState.value = true;
    } else {
      isEmptyTransactionState.value = false;
    }
  }
}
