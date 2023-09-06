import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/input_transaction_dto.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/frequency_enum.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

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
final submitTransactionAction = Atom<InputTransactionDTO?>(null);
final selectCategoryAction = Atom<String?>(null);
final selectFrequencyAction = Atom<String?>(null);
