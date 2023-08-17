import 'package:elevo/core/entity/transaction.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITransactionRepository {
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions();
  Future<Result<TransactionEntity, Exception>> getTransaction(String id);
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction);
  Future<Result<TransactionEntity, Exception>> deleteTransaction(String id);
  Future<Result<TransactionEntity, Exception>> updateTransaction(String updatedTransaction);
}
