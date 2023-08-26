import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/transaction_atoms.dart';
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

    final result = await Future.delayed(Duration(seconds: 5), () async {
      return await repository.getAllTransactions();
    });

    result.fold(
      (transactions) {
        listTransactionAtom.value.clear();
        listTransactionAtom.value = transactions;
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
        final index = listTransactionAtom.value.indexWhere((tr) => tr.id == id);
        listTransactionAtom.value.removeAt(index);
        selectedTransactionAtom.value = transaction;
      },
      (error) {},
    );

    isLoadingState.value = false;
  }

  Future<void> delete() async {
    isLoadingState.value = true;

    final id = deleteTransactionAction.value!;
    final index = listTransactionAtom.value.indexWhere((tr) => tr.id == id);
    final saved = listTransactionAtom.value[index];

    listTransactionAtom.value.removeAt(index);

    final result = await repository.deleteTransaction(id);
    result.fold(
      (_) {},
      (error) {
        listTransactionAtom.value[index] = saved;
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
