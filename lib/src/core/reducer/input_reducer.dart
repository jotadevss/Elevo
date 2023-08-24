import 'package:asp/asp.dart';
import 'package:elevo/main.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/data/repositories/sql_transaction_repository.dart';

/// Reducer class responsible for handling input submission and validation.
class InputReducer extends Reducer {
  final ITransactionRepository repository;

  // Constructor for the InputReducer class.
  /// Initializes the [repository] and defines the action to be triggered upon submitting a transaction.
  InputReducer({required this.repository}) {
    on(() => [submitTransactionAction], submit);
  }

  /// Handles the submission of a transaction.
  Future<void> submit() async {
    isLoadingState.value = true;

    final input = submitTransactionAction.value!;
    final isValid = validate(input); // call validator data input function

    if (!isValid) return;

    final id = uuid.v4(); // Generate unique id
    final transaction = InputTransactionDTO.toTransaction(id, input);

    // Create transaction in database
    final result = await repository.createTransaction(transaction);
    result.fold(
      (transactionResult) {
        ///  Navigate to [Success] page...
      },
      (error) {
        ///  Navigate to [Error] page with [error]...
      },
    );

    isLoadingState.value = false;
  }

  // Validates the input transaction data.
  // Returns true if the input is valid, otherwise returns false.
  bool validate(InputTransactionDTO input) {
    // status validation
    bool containsError = false;

    // verify value if the value is equals 0 or minus of 0
    if (input.value <= 0) {
      containsError = true;
      isValueError.value = true;
    }

    // verify category if category is selected
    if (input.category.isEmpty) {
      containsError = true;
      isCategoryError.value = true;
    }

    // return the status of validation
    return !containsError;
  }
}
