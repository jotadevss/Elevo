import 'package:asp/asp.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final allCateroiesAtom = Atom<List<CategoryEntity>>([]);

// Getters
List<CategoryEntity> get categories => [...allCateroiesAtom.value];

// Getters
List<CategoryEntity> get incomesCategories => allCateroiesAtom.value.where((c) => c.type == TypeTransaction.income.name).toList();
List<CategoryEntity> get expensesCategories => allCateroiesAtom.value.where((c) => c.type == TypeTransaction.expense.name).toList();

// Actions
final loadAllCategoriesAction = Atom.action();
