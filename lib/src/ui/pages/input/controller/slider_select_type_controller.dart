import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final selectedTypeAtom = Atom<TypeTransaction>(TypeTransaction.income);

// Action
final changeTypeAction = Atom<TypeTransaction?>(null);

// Reducer
class SliderSelectTypeReducer extends Reducer {
  SliderSelectTypeReducer() {
    on(() => [changeTypeAction], change);
  }

  void change() {
    if (selectedTypeAtom.value != changeTypeAction.value) {
      categoryAtom.value = null;
    }
    selectedTypeAtom.value = changeTypeAction.value ?? TypeTransaction.income;
  }
}
