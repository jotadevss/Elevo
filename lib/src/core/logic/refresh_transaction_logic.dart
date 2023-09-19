// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

// This class is responsible for fetching transactions
// through a forced update.
/// Used through a [refresh] for example.
class RefreshTransactionLogic {
  RefreshTransactionLogic({required this.repository});

  final ITransactionRepository repository;

  Future<void> call() async {
    // Requesting the transactions by repository and handle the data from result...
    final result = await repository.getAllTransactions();
    result.fold((transactions) {
      // If everything goes well, the data is stored in the cache
      cacheTransaction.value.clear(); // clear the cache and...
      cacheTransaction.value = transactions; // ...then add the updated list
      // this is used to avoid duplication
    }, (_) => null);
  }
}

/// Share instance for app [refresh] [RefreshTransactionLogic]
final refresh = RefreshTransactionLogic(repository: SQLTransactionRepositoryImpl());
