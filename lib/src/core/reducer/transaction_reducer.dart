import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

class TransactionReducer extends Reducer {
  final ITransactionRepository repository;

  TransactionReducer({required this.repository}) {
    on(() => [getAllTransactionAction], getAll);
    on(() => [getByIdTransactionAction], getById);
    on(() => [deleteTransactionAction], delete);
  }

  Future<void> getAll() async {
    isLoadingState.value = true;

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
    isLoadingState.value = true;

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
    isLoadingState.value = true;

    final id = deleteTransactionAction.value!;
    final index = cacheTransaction.value.indexWhere((tr) => tr.id == id);
    final saved = cacheTransaction.value[index];

    cacheTransaction.value.removeAt(index);

    final result = await repository.deleteTransaction(id);
    result.fold(
      (_) {},
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
