import 'dart:developer';
import 'package:elevo/core/dto/scheduled_transaction.dto.dart';
import 'package:elevo/domain/exception/custom_exception.dart';
import 'package:elevo/data/sql/sql_config.dart';
import 'package:elevo/data/sql/sql_helper.dart';
import 'package:result_dart/result_dart.dart';

abstract class IScheduledTransactionRepository {
  Future<Result<List<ScheduledTransactionDTO>, Exception>> findAllScheduledTransaction(String frequencyType);
  Future<Result<ScheduledTransactionDTO, Exception>> newAppointmentReference(ScheduledTransactionDTO reference);
}

class ScheduledTransactionRepository implements IScheduledTransactionRepository {
  SQLHelper database = SQLHelper(
    databaseName: SQLConfig.schedulerDatabaseName,
    tableName: SQLConfig.schedulerTableName,
    props: SQLConfig.schedulerProperty,
  );

  @override
  Future<Result<List<ScheduledTransactionDTO>, Exception>> findAllScheduledTransaction(String frequencyType) async {
    try {
      final data = await database.getByPropQuery('frequencyType', frequencyType);
      final dto = List.generate(
        data.length,
        (i) => ScheduledTransactionDTO.fromMap(data[i]),
      );
      return Success(dto);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<ScheduledTransactionDTO, Exception>> newAppointmentReference(ScheduledTransactionDTO reference) async {
    try {
      await database.saveDataQuery(reference.toMap());
      return Success(reference);
    } catch (e) {
      log(e.toString());
      return Failure(CustomException(message: e.toString()));
    }
  }
}
