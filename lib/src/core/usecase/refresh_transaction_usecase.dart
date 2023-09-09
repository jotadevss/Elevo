// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

import '../atoms/transaction/transaction_atoms.dart';

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
