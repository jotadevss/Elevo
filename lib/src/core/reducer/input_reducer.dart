import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/router.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class InputReducer extends Reducer {
  final ITransactionRepository repository;

  InputReducer({required this.repository}) {
    on(() => [submitTransactionAction], submit);
  }

  Future<void> submit() async {
    isLoadingState.value = true;

    final input = inputDTO;
    final isValid = validate(input);

    if (!isValid) {
      isLoadingState.value = false;
      return;
    }

    final id = '1';
    final transaction = InputTransactionDTO.toTransaction(id, input);

    final result = await repository.createTransaction(transaction);
    result.fold(
      (transaction) {
        listTransactionAtom.value.add(transaction);
        log(
          '${transaction.id} | ${transaction.value} |${transaction.type} |${transaction.createAt} |${transaction.frequency} |${transaction.description}',
        );
        router.go(AppRouter.INPUT_SUCCESS_PAGE_ROUTER);
      },
      (error) {
        log(error.toString());
      },
    );

    isLoadingState.value = false;
  }

  bool validate(InputTransactionDTO input) {
    bool containsError = false;

    if (input.value <= 0) {
      containsError = true;
      isValueError.value = true;
    }

    if (input.category.isEmpty || input.category == '') {
      containsError = true;
      isCategoryError.value = true;
    }

    return !containsError;
  }
}
