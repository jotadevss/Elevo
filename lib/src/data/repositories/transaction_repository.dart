import 'dart:developer';

import 'package:elevo/src/core/adapter/transaction_adapter.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/exception/custom_exception.dart';
import 'package:elevo/src/data/sql/sql_config.dart';
import 'package:elevo/src/data/sql/sql_helper.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITransactionRepository {
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions();
  Future<Result<TransactionEntity, Exception>> getTransaction(String id);
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction);
  Future<Result<String, Exception>> deleteTransaction(String id);
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction);
}

class TransactionRepositoryImpl implements ITransactionRepository {
  SQLHelper database = SQLHelper(
    databaseName: SQLConfig.transactionDatabaseName,
    tableName: SQLConfig.transactionTableName,
    props: SQLConfig.transactionProperty,
  );

  @override
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction) async {
    try {
      await database.saveDataQuery(TransactionAdapter.toMap(transaction));
      return Success(transaction);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<String, Exception>> deleteTransaction(String id) async {
    try {
      await database.deleteDataQuery(id);
      return const Success('Success');
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions() async {
    try {
      final data = await database.getDataQuery();
      final transaction = List.generate(
        data.length,
        (i) => TransactionAdapter.fromMap(
          data[i],
        ),
      );
      return Success(transaction);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<TransactionEntity, Exception>> getTransaction(String id) async {
    try {
      final data = await database.getByIdDataQuery(id);
      final transaction = TransactionAdapter.fromMap(data);
      return Success(transaction);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction) async {
    try {
      await database.updateDataQuery(TransactionAdapter.toMap(updatedTransaction));
      return Success(updatedTransaction);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }
}
