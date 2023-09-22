import 'dart:developer';
import 'package:elevo/src/data/sql/sql_config.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/frequency_enum.dart';
import 'package:elevo/src/domain/enums/sql_error_enums.dart';
import 'package:elevo/src/domain/exception/sql_exception.dart';
import 'package:result_dart/result_dart.dart';

import '../sql/sql_helper.dart';

abstract class IScheduleTransaction {
  Future<Result<List<TransactionEntity>, Exception>> getDailyTransactionRecords();
  Future<Result<List<TransactionEntity>, Exception>> getMonthlyTransactionRecords();
  Future<Result<List<TransactionEntity>, Exception>> getYearlyTransactionRecords();
  Future<Result<TransactionEntity, Exception>> createScheduledTransactionRecords(TransactionEntity dto);
  Future<Result<String, Exception>> deleteRecordById(String id);
}

class SQLScheduleTransaction implements IScheduleTransaction {
  // Instance of the SQLHelper class to manage database operations.
  final SQLHelper _database = SQLHelper(
    databaseName: SQLConfig.scheduleTransactionDatabaseName,
    tableName: SQLConfig.scheduleTransactionTableName,
    props: SQLConfig.scheduleTransactionProperty,
  );
  @override
  Future<Result<String, Exception>> deleteRecordById(String id) async {
    try {
      await _database.deleteDataQuery(id);
      return const Success('Success');
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<TransactionEntity, Exception>> createScheduledTransactionRecords(TransactionEntity dto) async {
    try {
      await _database.saveDataQuery(dto.toMap());
      return Success(dto);
    } on SQLException catch (e) {
      log(e.toString());
      return Failure(e);
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Exception>> getDailyTransactionRecords() async {
    try {
      final data = await _database.getByPropQuery("frequency", Frequency.daily.name);
      final records = List.generate(data.length, (i) => TransactionEntity.fromMap(data[i]));
      return Success(records);
    } on SQLException catch (e) {
      if (e.message[e] == SQLError.notFound) {
        return const Success([]);
      }
      return Failure(e);
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Exception>> getMonthlyTransactionRecords() async {
    try {
      final data = await _database.getByPropQuery("frequency", Frequency.monthly.name);
      final records = List.generate(data.length, (i) => TransactionEntity.fromMap(data[i]));
      return Success(records);
    } on SQLException catch (e) {
      if (e.message[e] == SQLError.notFound) {
        return const Success([]);
      }
      return Failure(e);
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Exception>> getYearlyTransactionRecords() async {
    try {
      final data = await _database.getByPropQuery("frequency", Frequency.yearly.name);
      final records = List.generate(data.length, (i) => TransactionEntity.fromMap(data[i]));
      return Success(records);
    } on SQLException catch (e) {
      if (e.message[e] == SQLError.notFound) {
        return const Success([]);
      }
      return Failure(e);
    }
  }
}
