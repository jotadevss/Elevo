// Atoms
import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:flutter/widgets.dart';

final allCateroiesAtom = Atom<List<CategoryEntity>>([]);

// Getters
List<CategoryEntity> get categories => [...allCateroiesAtom.value];
List<CategoryEntity> get incomesCategories => allCateroiesAtom.value.where((c) => c.type == TypeTransaction.income.name).toList();
List<CategoryEntity> get expensesCategories => allCateroiesAtom.value.where((c) => c.type == TypeTransaction.expense.name).toList();

// Actions
final loadAllCategoriesAction = Atom.action();

// Reducer
class CategoryReducer extends Reducer {
  final ICategoryRepository repository;

  CategoryReducer({required this.repository}) {
    on(() => [loadAllCategoriesAction], loadCategories);
  }

  Future<void> loadCategories() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      isLoadingState.value = true;
    });

    final result = await repository.getAllCategories();
    result.fold(
      (categories) {
        allCateroiesAtom.value = categories;
      },
      (error) {},
    );

    isLoadingState.value = false;
  }
}
