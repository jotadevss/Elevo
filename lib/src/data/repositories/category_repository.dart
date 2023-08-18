import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/exception/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

abstract class ICategoryRepository {
  Future<Result<List<CategoryEntity>, Exception>> getAllCategories();
}

class CategoryRepository implements ICategoryRepository {
  @override
  Future<Result<List<CategoryEntity>, Exception>> getAllCategories() async {
    try {
      return Success(_allConstantsCategories);
    } catch (e) {
      return Failure(CustomException(message: e.toString()));
    }
  }

  final _allConstantsCategories = <CategoryEntity>[
    // Initial list of categories
    CategoryEntity(
      id: 'content-wage',
      title: 'Wage',
      type: "incomes",
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-investment',
      title: 'incomes Investment',
      type: 'incomes',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-other-incomes',
      title: 'Others',
      type: 'incomes',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-home',
      title: 'Home',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-transport',
      title: 'Transport',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-food',
      title: 'Food',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-health',
      title: 'Health',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-leisure',
      title: 'Leisure',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-taxes',
      title: 'Taxes',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
    CategoryEntity(
      id: 'content-other-expenses',
      title: 'Other',
      type: 'expenses',
      iconPath: 'car_repair',
      hexColor: Colors.black.value,
    ),
  ];
}
