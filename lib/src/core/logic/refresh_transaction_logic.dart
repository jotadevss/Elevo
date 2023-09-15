// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

class RefreshTransactionUsecase {
  RefreshTransactionUsecase({required this.repository});

  final ITransactionRepository repository;

  Future<void> call() async {
    final result = await repository.getAllTransactions();
    result.fold((transactions) {
      cacheTransaction.value.clear();
      cacheTransaction.value = transactions;
    }, (_) => null);
  }
}

final refresh = RefreshTransactionUsecase(repository: SQLTransactionRepositoryImpl());
