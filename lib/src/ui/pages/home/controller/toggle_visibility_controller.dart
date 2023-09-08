import 'package:asp/asp.dart';

// Atom
final isVisibleAtom = Atom<bool>(true);

// Action
final toggleVisibilityAction = Atom.action();

// Reducer
class ToggleVisibilityController extends Reducer {
  ToggleVisibilityController() {
    on(() => [toggleVisibilityAction], () {
      isVisibleAtom.value = !isVisibleAtom.value;
    });
  }
}
