import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/data/sql/sql_config.dart';
import 'package:elevo/src/data/sql/sql_helper.dart';
import 'package:elevo/src/domain/exception/sql_exception.dart';
import 'package:result_dart/result_dart.dart';

/// This abstract class defines the contract for interacting with transaction data.
abstract class ITransactionRepository {
  /// Retrieves all transactions.
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions();

  /// Retrieves a single transaction by its ID.
  Future<Result<TransactionEntity, Exception>> getTransaction(String id);

  /// Creates a new transaction.
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction);

  /// Deletes a transaction by its ID.
  Future<Result<String, Exception>> deleteTransaction(String id);

  /// Updates an existing transaction.
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction);
}

/// This class provides an implementation of the ITransactionRepository interface
/// using a SQL database.
class SQLTransactionRepositoryImpl implements ITransactionRepository {
  // Instance of the SQLHelper class to manage database operations.
  final SQLHelper _database = SQLHelper(
    databaseName: SQLConfig.transactionDatabaseName,
    tableName: SQLConfig.transactionTableName,
    props: SQLConfig.transactionProperty,
  );

  /// Creates a new transaction in the database.
  ///
  /// Returns a [Success] result containing the created transaction if successful,
  /// or a [Failure] result containing an exception if an error occurs.
  @override
  Future<Result<TransactionEntity, Exception>> createTransaction(TransactionEntity transaction) async {
    try {
      await _database.saveDataQuery(transaction.toMap());
      return Success(transaction);
    } on SQLException catch (e) {
      return Failure(e);
    }
  }

  /// Deletes a transaction from the database by its ID.
  ///
  /// Returns a [Success] result with a message 'Success' if the deletion is successful,
  /// or a [Failure] result containing an exception if an error occurs.
  @override
  Future<Result<String, Exception>> deleteTransaction(String id) async {
    try {
      await _database.deleteDataQuery(id);
      return const Success('Success');
    } on SQLException catch (e) {
      return Failure(e);
    }
  }

  /// Retrieves a list of all transactions from the database.
  ///
  /// Returns a [Success] result containing a list of [TransactionEntity] objects if successful,
  /// or a [Failure] result containing an exception if an error occurs.
  @override
  Future<Result<List<TransactionEntity>, Exception>> getAllTransactions() async {
    try {
      final data = await _database.getDataQuery();
      final transactions = List.generate(
        data.length,
        (i) => TransactionEntity.fromMap(data[i]),
      );
      return Success(transactions);
    } on SQLException catch (e) {
      return Failure(e);
    }
  }

  /// Retrieves a single transaction by its ID from the database.
  ///
  /// Returns a [Success] result containing the retrieved [TransactionEntity] object if successful,
  /// or a [Failure] result containing an exception if an error occurs.
  @override
  Future<Result<TransactionEntity, Exception>> getTransaction(String id) async {
    try {
      final data = await _database.getByIdDataQuery(id);
      final transaction = TransactionEntity.fromMap(data);
      return Success(transaction);
    } on SQLException catch (e) {
      return Failure(e);
    }
  }

  /// Updates an existing transaction in the database.
  ///
  /// Returns a [Success] result containing the updated [TransactionEntity] object if successful,
  /// or a [Failure] result containing an exception if an error occurs.
  @override
  Future<Result<TransactionEntity, Exception>> updateTransaction(TransactionEntity updatedTransaction) async {
    try {
      await _database.updateDataQuery(updatedTransaction.toMap());
      return Success(updatedTransaction);
    } on SQLException catch (e) {
      return Failure(e);
    }
  }
}
