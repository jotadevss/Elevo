import 'package:elevo/core/dto/scheduled_transaction.dto.dart';
import 'package:result_dart/result_dart.dart';

abstract class IScheduledTransactionRepository {
  Future<Result<List<ScheduledTransactionDTO>, Exception>> findAllScheduledTransaction(String referenceId);
  Future<Result<List<ScheduledTransactionDTO>, Exception>> newAppointmentReference(ScheduledTransactionDTO reference);
}
