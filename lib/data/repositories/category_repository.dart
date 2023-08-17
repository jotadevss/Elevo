import 'package:elevo/core/entity/category.dart';
import 'package:result_dart/result_dart.dart';

abstract class ICategoryRepository {
  Future<Result<List<CategoryEntity>, Exception>> getAllCategories();
}
