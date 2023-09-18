// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:flutter/widgets.dart';

// Atoms
final allCategoriesAtom = Atom<List<CategoryEntity>>([]);

// Getters
List<CategoryEntity> get getAllCategories => [...allCategoriesAtom.value];
List<CategoryEntity> get getIncomesCategories => allCategoriesAtom.value.where((c) => c.type == TypeTransaction.income.name).toList();
List<CategoryEntity> get getExpensesCategories => allCategoriesAtom.value.where((c) => c.type == TypeTransaction.expense.name).toList();

// Actions
final loadAllCategoriesAction = Atom.action();

// Reducer
class CategoryReducer extends Reducer {
  final ICategoryRepository repository;

  CategoryReducer({required this.repository}) {
    // Handle actions
    on(() => [loadAllCategoriesAction], loadCategories);
  }

  // This method load all categories
  /// Every time the [action] [loadAllCategoriesAction] is called
  Future<void> loadCategories() async {
    // This method ensures the function called after build the state
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      isLoadingState.value = true;
    });

    // Requesting the categories by repository and handle the data from result...s
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
    isLoadingState.value = false;
  }
}
