import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/pages/input/controller/date_picker_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class InputReducer extends Reducer {
  final ITransactionRepository repository;

  InputReducer({required this.repository}) {
    on(() => [submitTransactionAction], submit);
    on(() => [clearAction], clear);
  }

  Future<void> submit() async {
    isLoadingState.value = true;

    final input = InputTransactionDTO(
      value: valueAtom.value,
      type: typeAtom.value,
      category: categoryAtom.value!.id,
      createAt: createAtAtom.value,
      frequency: frequencyAtom.value,
      description: descriptionAtom.value,
    );

    final isValid = validate(input);

    if (!isValid) {
      isLoadingState.value = false;
      return;
    }

    final id = '1';
    final transaction = InputTransactionDTO.toTransaction(id, input);

    final result = await repository.createTransaction(transaction);
    await result.fold(
      (success) {
        listTransactionAtom.value.add(success);
        router.go(AppRouter.INPUT_SUCCESS_PAGE_ROUTER);
      },
      (error) {
        log(error.toString());
      },
    );
    clearAction.call();
    isLoadingState.value = false;
  }

  bool validate(InputTransactionDTO input) {
    bool containsError = false;

    if (input.value <= 0) {
      containsError = true;
      isValueError.value = true;
    } else {
      isValueError.value = false;
    }

    if (input.category.isEmpty || input.category == '') {
      containsError = true;
      isCategoryError.value = true;
    } else {
      isCategoryError.value = false;
    }

    return !containsError;
  }

  void clear() {
    // Clear data input
    valueAtom.value = 0.0;
    categoryAtom.value = null;
    typeAtom.value = TypeTransaction.income.name;
    createAtAtom.value = DateTime.now();
    frequencyAtom.value = null;
    descriptionAtom.value = null;

    // Clear controllers
    selectedTypeAtom.value = TypeTransaction.income;
    valueSwitchIsFixedAtom.value = false;
    dateSelectedAtom.value = DateTime.now();

    // Clear errors
    clearErrors();
  }

  void clearErrors() {
    isCategoryError.value = false;
    isValueError.value = false;
  }
}
