// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final allCategoriesAtom = Atom<List<CategoryEntity>>([]);

// Getters
List<CategoryEntity> get getAllCategories {
  /// Returns a copy of [allCategoriesAtom] value
  return [...allCategoriesAtom.value];
}

List<CategoryEntity> get getIncomesCategories {
  return allCategoriesAtom // Filter by Incomes
      .value
      .where((c) => c.type == TypeTransaction.income.name)
      .toList();
}

List<CategoryEntity> get getExpensesCategories {
  return allCategoriesAtom // Filter by Expense
      .value
      .where((c) => c.type == TypeTransaction.expense.name)
      .toList();
}

// Actions
final loadAllCategoriesAction = Atom.action();

// Reducer
class CategoryLogic extends Reducer {
  final ICategoryRepository repository;

  CategoryLogic({required this.repository}) {
    // Handle actions
    on(() => [loadAllCategoriesAction], loadCategories);
  }

  // This method load all categories
  /// Every time the [action] [loadAllCategoriesAction] is called
  Future<void> loadCategories() async {
    /// Start the loading state [isLoadingState]
    startLoadingAction.call();

    // Requesting the categories by repository and handle the data from result...
    final result = await repository.getAllCategories();
    result.fold(
      /// [categories] returns categories fetched from database
      /// [error] return a message or exception when happens any problem in request
      (categories) {
        // assigns the fetched categories in atom to share to app
        allCategoriesAtom.value = categories;
      },
      (error) {},
    );

    // Turn off the loading state
    stopLoadingAction.call();
  }
}
