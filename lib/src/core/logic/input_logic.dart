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
import 'package:uuid/uuid.dart';

// Constants
final mapFrequency = [
  {
    'title': 'Daily',
    'description': 'Will be updated daily',
    'id': Frequency.daily.name,
  },
  {
    'title': 'Monthly',
    'description': 'Will be updated monthly',
    'id': Frequency.monthly.name,
  },
  {
    'title': 'Yearly',
    'description': 'Will be updated yearly',
    'id': Frequency.yearly.name,
  },
];

// Atoms Data
final valueDataState = Atom<double>(0.0);
final typeDataState = Atom<String>(TypeTransaction.income.name);
final categoryDataState = Atom<CategoryEntity?>(null);
final createAtDataState = Atom<DateTime>(DateTime.now());
final frequencyDataState = Atom<String?>(null);
final descriptionDataState = Atom<String?>(null);

// Atoms Errors
final isValueErrorState = Atom<bool>(false);
final isCategoryErrorState = Atom<bool>(false);

// Actions
final submitTransactionAction = Atom.action();
final clearDataAction = Atom.action();

// Generator of Uuid for transactions
var uuid = const Uuid();

class InputLogic extends Reducer {
  final ITransactionRepository repository;

  InputLogic({required this.repository}) {
    // Handle Actions
    on(() => [submitTransactionAction], submit);
    on(() => [clearDataAction], clear);
  }

  // Submit method valid and create a new transaction in storage
  Future<void> submit() async {
    /// Start the loading state [isLoadingState]
    startLoadingAction.call();

    // Takes datas from the user and converting in a DTO
    /// and model the data to DTO [InputTransactionDTO]
    final input = InputTransactionDTO(
      value: valueDataState.value.roundToDouble(),
      type: typeDataState.value,
      category: categoryDataState.value?.id ?? '',
      createAt: createAtDataState.value,
      frequency: frequencyDataState.value,
      description: descriptionDataState.value,
    );

    // Call Validate input data value
    final isValid = validate(input);

    // If there are errors in validation, the function will go to execution
    if (!isValid) {
      stopLoadingAction.call();
      return;
    }

    // Generate the id for transaction
    final id = uuid.v4();
    final transaction = InputTransactionDTO.toTransaction(id, input);

    // Requesting the add the transaction by repository and handle status from result...
    final result = await repository.createTransaction(transaction);
    await result.fold(
      (success) {
        // If everything goes well, the data is stored in the cache
        cacheTransaction.value.add(success);
        router.go(AppRouter.INPUT_SUCCESS_PAGE_ROUTER); // Go to Success Page
      },
      (error) {
        log(error.toString());
      },
    );

    // CLear all data values
    clearDataAction.call();

    /// Stop the loading state [isLoadingState]
    stopLoadingAction.call();
  }

  bool validate(InputTransactionDTO input) {
    bool containsError = false;

    // Value validated condition
    if (input.value <= 0) {
      containsError = true;
      isValueErrorState.value = true;
    } else {
      isValueErrorState.value = false;
    }

    // Category validated condition
    if (input.category.isEmpty || input.category == '') {
      containsError = true;
      isCategoryErrorState.value = true;
    } else {
      isCategoryErrorState.value = false;
    }

    return !containsError;
  }

  void clear() {
    // Clear data input
    valueDataState.value = 0.0;
    categoryDataState.value = null;
    typeDataState.value = TypeTransaction.income.name;
    createAtDataState.value = DateTime.now();
    frequencyDataState.value = null;
    descriptionDataState.value = null;

    // Clear controllers
    selectedTypeAtom.value = TypeTransaction.income;
    valueSwitchIsFixedAtom.value = false;
    toggleSwitchIsFixedAction.value = false;
    dateSelectedAtom.value = DateTime.now();

    // Clear errors
    isCategoryErrorState.value = false;
    isValueErrorState.value = false;
  }
}
