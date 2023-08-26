import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Default value
InputTransactionDTO input = InputTransactionDTO(
  value: 10.0,
  type: TypeTransaction.incomes.name,
  category: 'other',
  createAt: DateTime.now(),
  frequency: '',
  description: '',
);

// Atoms
final inputDataAtom = Atom<InputTransactionDTO>(input);

// Errors
final isValueError = Atom<bool>(false);
final isCategoryError = Atom<bool>(false);

// Actions
final submitTransactionAction = Atom<InputTransactionDTO?>(inputDataAtom.value);
final selectCategoryAction = Atom<String?>(null);
final selectFrequencyAction = Atom<String?>(null);
