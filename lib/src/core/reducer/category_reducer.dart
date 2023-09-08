import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/category_atom.dart';
import 'package:elevo/src/data/repositories/local_category_repository.dart';
import 'package:flutter/material.dart';

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
