import 'package:asp/asp.dart';

// Atoms
final expandWidthAtom = Atom<bool>(false);

// Actions
final observerTextLengthAction = Atom<String?>(null);

// Reducer
class WidthInsertAmountController extends Reducer {
  WidthInsertAmountController() {
    on(() => [observerTextLengthAction], handlerWidth);
  }

  void handlerWidth() {
    final text = observerTextLengthAction.value ?? '';
    if (text.length >= 20) {
      expandWidthAtom.value = false;
    } else {
      text.length <= 3 ? expandWidthAtom.value = false : expandWidthAtom.value = true;
    }
  }
}
