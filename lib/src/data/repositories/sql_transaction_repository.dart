import 'dart:developer';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/sql_error_keys_enums.dart';
import 'package:elevo/src/data/sql/sql_config.dart';
import 'package:elevo/src/data/sql/sql_helper.dart';
import 'package:elevo/src/domain/exception/sql_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITransactionRepository {
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions();
  Future<Result<TransactionEntity, Exception>> getTransaction(String id);
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction);
  Future<Result<String, Exception>> deleteTransaction(String id);
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction);
}

class SQLTransactionRepositoryImpl implements ITransactionRepository {
  final SQLHelper _database = SQLHelper(
    databaseName: SQLConfig.transactionDatabaseName,
    tableName: SQLConfig.transactionTableName,
    props: SQLConfig.transactionProperty,
  );

  @override
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction) async {
    try {
      await _database.saveDataQuery(transaction.toMap());
      return Success(transaction);
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<String, Exception>> deleteTransaction(String id) async {
    try {
      await _database.deleteDataQuery(id);
      return const Success('Success');
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions() async {
    try {
      final data = await _database.getDataQuery();
      final transaction = List.generate(
        data.length,
        (i) => TransactionEntity.fromMap(data[i]),
      );
      return Success(transaction);
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<TransactionEntity, Exception>> getTransaction(String id) async {
    try {
      final data = await _database.getByIdDataQuery(id);
      final transaction = TransactionEntity.fromMap(data);
      return Success(transaction);
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction) async {
    try {
      await _database.updateDataQuery(updatedTransaction.toMap());
      return Success(updatedTransaction);
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }
}
