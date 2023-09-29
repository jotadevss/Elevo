import 'package:elevo/src/utils/constants.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/domain/exception/custom_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ICategoryRepository {
  Future<Result<List<CategoryEntity>, Exception>> getAllCategories();
}

class LocalCategoryRepository implements ICategoryRepository {
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
      type: "income",
      iconPath: 'lib/assets/icons/money.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-investment-incomes',
      title: 'Investment',
      type: 'income',
      iconPath: 'lib/assets/icons/status-up.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-investment-expense',
      title: 'Investment',
      type: 'expense',
      iconPath: 'lib/assets/icons/status-up.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-other-income',
      title: 'Others',
      type: 'income',
      iconPath: 'lib/assets/icons/more-circle.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-home',
      title: 'Home',
      type: 'expense',
      iconPath: 'lib/assets/icons/home-2.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-transport',
      title: 'Transport',
      type: 'expense',
      iconPath: 'lib/assets/icons/car.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-food',
      title: 'Food',
      type: 'expense',
      iconPath: 'lib/assets/icons/bag.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-health',
      title: 'Health',
      type: 'expense',
      iconPath: 'lib/assets/icons/heart.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-leisure',
      title: 'Leisure',
      type: 'expense',
      iconPath: 'lib/assets/icons/sun.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-taxes',
      title: 'Taxes',
      type: 'expense',
      iconPath: 'lib/assets/icons/receipt.svg',
      hexColor: kPrimaryColor.value,
    ),
    CategoryEntity(
      id: 'content-other-expense',
      title: 'Other',
      type: 'expense',
      iconPath: 'lib/assets/icons/more-circle.svg',
      hexColor: kPrimaryColor.value,
    ),
  ];
}
