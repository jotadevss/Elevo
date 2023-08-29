import 'package:asp/asp.dart';
import 'package:elevo/src/domain/entity/category.dart';

// Atoms
final allCateroiesAtom = Atom<List<CategoryEntity>>([]);

// Actions
final loadAllCategoriesAction = Atom.action();
