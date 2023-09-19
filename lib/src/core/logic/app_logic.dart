import 'package:asp/asp.dart';
import 'package:flutter/widgets.dart';

// Atoms
final isLoadingState = Atom<bool>(false);

// Actions
final startLoadingAction = Atom.action();
final stopLoadingAction = Atom.action();

class AppReducer extends Reducer {
  AppReducer() {
    on(() => [startLoadingAction], startLoading);
    on(() => [stopLoadingAction], stopLoading);
  }

  void startLoading() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      isLoadingState.value = true;
    });
  }

  void stopLoading() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      isLoadingState.value = false;
    });
  }
}
