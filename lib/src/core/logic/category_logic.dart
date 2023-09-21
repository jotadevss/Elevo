// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final allCategoriesAtom = Atom<List<CategoryEntity>>([]);

// Getters
// This code provides three getter functions to get all categories, incomes categories, and expenses categories.
//
// The `getAllCategories` getter function returns a copy of the `allCategoriesAtom` state atom. The `allCategoriesAtom` state atom stores a list of all categories.
//
// The `getIncomesCategories` getter function returns a list of all incomes categories. It filters the `allCategoriesAtom` state atom to only include categories with the `TypeTransaction.income` type.
//
// The `getExpensesCategories` getter function returns a list of all expenses categories. It filters the `allCategoriesAtom` state atom to only include categories with the `TypeTransaction.expense` type.
//
// [Image of a pie chart with two slices, one for incomes and one for expenses.]

List<CategoryEntity> get getAllCategories {
  // Returns a copy of the `allCategoriesAtom` state atom.
  return [...allCategoriesAtom.value];
}

List<CategoryEntity> get getIncomesCategories {
  // Returns a list of all incomes categories.
  return allCategoriesAtom.value.where((c) => c.type == TypeTransaction.income.name).toList();
}

List<CategoryEntity> get getExpensesCategories {
  // Returns a list of all expenses categories.
  return allCategoriesAtom.value.where((c) => c.type == TypeTransaction.expense.name).toList();
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
