import 'package:asp/asp.dart';
import 'package:flutter/widgets.dart';

// Atoms
final isLoadingState = Atom<bool>(false);

// Actions
final startLoadingAction = Atom.action();
final stopLoadingAction = Atom.action();

class AppLogic extends Reducer {
  AppLogic() {
    // Handle Actions
    on(() => [startLoadingAction], startLoading);
    on(() => [stopLoadingAction], stopLoading);
  }

  void startLoading() {
    // This method ensures the function called after build the state
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      isLoadingState.value = true;
    });
  }

  void stopLoading() {
    // This method ensures the function called after build the state
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      isLoadingState.value = false;
    });
  }
}
