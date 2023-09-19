import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';

// Atoms
final selectedTypeAtom = Atom<TypeTransaction>(TypeTransaction.income);

// Action
final changeTypeAction = Atom<TypeTransaction?>(null);

// Reducer
class SliderSelectTypeController extends Reducer {
  SliderSelectTypeController() {
    on(() => [changeTypeAction], change);
  }

  void change() {
    if (selectedTypeAtom.value != changeTypeAction.value) {
      categoryDataState.value = null;
    }
    selectedTypeAtom.value = changeTypeAction.value ?? TypeTransaction.income;
  }
}
