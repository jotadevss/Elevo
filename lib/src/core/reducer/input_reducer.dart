import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

class InputReducer extends Reducer {
  final ITransactionRepository repository;

  InputReducer({required this.repository}) {
    on(() => [submitTransactionAction], submit);
  }

  Future<void> submit() async {
    isLoadingState.value = true;

    final input = submitTransactionAction.value!;
    final isValid = validate(input);
    if (!isValid) return;

    final id = '1';
    final transaction = InputTransactionDTO.toTransaction(id, input);

    final result = await repository.createTransaction(transaction);
    result.fold(
      (transaction) {
        listTransactionAtom.value.add(transaction);
      },
      (error) {},
    );

    isLoadingState.value = false;
  }

  bool validate(InputTransactionDTO input) {
    bool containsError = false;

    if (input.value <= 0) {
      containsError = true;
      isValueError.value = true;
    }

    if (input.category.isEmpty) {
      containsError = true;
      isCategoryError.value = true;
    }

    return !containsError;
  }
}
