import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/frequency_enum.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/pages/input/controller/date_picker_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

// Constants
final frequencies = [
  {'title': 'Daily', 'description': 'Will be updated daily', 'id': Frequency.daily.name},
  {'title': 'Monthly', 'description': 'Will be updated monthly', 'id': Frequency.monthly.name},
  {'title': 'Yearly', 'description': 'Will be updated yearly', 'id': Frequency.yearly.name},
];

// Data
final valueAtom = Atom<double>(0.0);
final typeAtom = Atom<String>(TypeTransaction.income.name);
final categoryAtom = Atom<CategoryEntity?>(null);
final createAtAtom = Atom<DateTime>(DateTime.now());
final frequencyAtom = Atom<String?>(null);
final descriptionAtom = Atom<String?>(null);

// Errors
final isValueError = Atom<bool>(false);
final isCategoryError = Atom<bool>(false);

// Actions
final submitTransactionAction = Atom.action();
final selectCategoryAction = Atom<String?>(null);
final selectFrequencyAction = Atom<String?>(null);
final clearAction = Atom.action();

var uuid = const Uuid();

class InputReducer extends Reducer {
  final ITransactionRepository repository;

  InputReducer({required this.repository}) {
    on(() => [submitTransactionAction], submit);
    on(() => [clearAction], clear);
  }

  Future<void> submit() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      isLoadingState.value = true;
    });
    final input = InputTransactionDTO(
      value: valueAtom.value.roundToDouble(),
      type: typeAtom.value,
      category: categoryAtom.value?.id ?? '',
      createAt: createAtAtom.value,
      frequency: frequencyAtom.value,
      description: descriptionAtom.value,
    );
    final isValid = validate(input);
    if (!isValid) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
        isLoadingState.value = false;
      });
      return;
    }
    final id = uuid.v4();
    final transaction = InputTransactionDTO.toTransaction(id, input);
    final result = await repository.createTransaction(transaction);
    await result.fold(
      (success) {
        cacheTransaction.value.add(success);
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
    toggleSwitchIsFixedAction.value = false;
    dateSelectedAtom.value = DateTime.now();
    // Clear errors
    clearErrors();
  }

  void clearErrors() {
    isCategoryError.value = false;
    isValueError.value = false;
  }
}
