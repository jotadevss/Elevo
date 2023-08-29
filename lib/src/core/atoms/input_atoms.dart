import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';

// Atoms
final inputDataAtom = Atom<Map<String, dynamic>>({});

// Errors
final isValueError = Atom<bool>(false);
final isCategoryError = Atom<bool>(false);

// Actions
final submitTransactionAction = Atom<InputTransactionDTO?>(null);
final selectCategoryAction = Atom<String?>(null);
final selectFrequencyAction = Atom<String?>(null);
