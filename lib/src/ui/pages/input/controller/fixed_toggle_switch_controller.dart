import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/domain/enums/frequency_enum.dart';

// Atoms
final valueSwitchIsFixedAtom = Atom<bool>(false);

// Actions
final toggleSwitchIsFixedAction = Atom<bool>(false);

// Reducer
class ToggleSwitchIsFixedReducer extends Reducer {
  ToggleSwitchIsFixedReducer() {
    on(() => [toggleSwitchIsFixedAction], () {
      valueSwitchIsFixedAtom.value = toggleSwitchIsFixedAction.value;
      (valueSwitchIsFixedAtom.value) ? frequencyAtom.value = Frequency.daily.name : frequencyAtom.value = null;
    });
  }
}
