import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/infra/repositories/app_preferences_repository.dart';
import 'package:flutter/widgets.dart';

// Atoms
// This is an immutable value that can be observed and changed.
final isLoadingState = Atom<bool>(false);
final isFirstTimeInAppState = Atom<bool>(true);

// Actions
// This is a function that can be used to change the state of the application.
final startLoadingAction = Atom.action();
final stopLoadingAction = Atom.action();
final verifyStatusAppAction = Atom.action();

class AppLogic extends Reducer {
  AppLogic() {
    // This method handles actions.
    on(() => [startLoadingAction], startLoading);
    on(() => [stopLoadingAction], stopLoading);
    on(() => [verifyStatusAppAction], verifyStatusApp);
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

  Future<void> verifyStatusApp() async {
    startLoading();
    final isFirstTime = await AppPreferences.getIsFirstRecord();
    log(isFirstTime.toString());
    if (isFirstTime) {
      isFirstTimeInAppState.value = true;
    } else {
      isFirstTimeInAppState.value = false;
    }
    stopLoading();
  }
}
