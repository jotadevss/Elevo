import 'package:asp/asp.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final selectedTypeAtom = Atom<TypeTransaction>(TypeTransaction.incomes);

// Action
final changeTypeAction = Atom<TypeTransaction?>(null);

// Reducer
class SliderSelectTypeReducer extends Reducer {
  SliderSelectTypeReducer() {
    on(() => [changeTypeAction], change);
  }

  void change() => selectedTypeAtom.value = changeTypeAction.value ?? TypeTransaction.incomes;
}
