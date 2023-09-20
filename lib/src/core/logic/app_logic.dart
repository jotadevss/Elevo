import 'package:asp/asp.dart';
import 'package:flutter/widgets.dart';

// Atoms
// This is an immutable value that can be observed and changed.
final isLoadingState = Atom<bool>(false);

// Actions
// This is a function that can be used to change the state of the application.
final startLoadingAction = Atom.action();
final stopLoadingAction = Atom.action();

class AppLogic extends Reducer {
  AppLogic() {
    // This method handles actions.
    on(() => [startLoadingAction], startLoading);
    on(() => [stopLoadingAction], stopLoading);
  }

  void startLoading() {
    // This method ensures that the function is called after the state is built.
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      // This method sets the loading state to true.
      isLoadingState.value = true;
    });
  }

  void stopLoading() {
    // This method ensures that the function is called after the state is built.
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      // This method sets the loading state to false.
      isLoadingState.value = false;
    });
  }
}
