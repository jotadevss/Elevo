import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:elevo/src/core/dto/create_user_dto.dart';
import 'package:elevo/src/core/dto/sign_in_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/domain/entity/user.dart';
import 'package:elevo/src/infra/repositories/app_preferences_repository.dart';
import 'package:elevo/src/infra/services/auth/interface_auth_with_email_and_password_service.dart';
import 'package:elevo/src/infra/services/auth/local_auth_biometrics_service.dart';

enum AuthState { logged, unlogged }

// Atom
final isAuthenticatedAtom = Atom<AuthState>(AuthState.logged);
final currentUserAtom = Atom<UserEntity?>(null);
final authErrorMessage = Atom<String?>(null);
final isAvailableAuthByBiometric = Atom<bool>(false);
final showAuthErrorAtom = Atom<bool>(false);

// Action
final checkAuthAction = Atom.action();
final signInWithEmailAndPasswordAction = Atom<SignInDTO?>(null);
final createWithEmailAndPasswordAction = Atom<CreateUserDTO?>(null);
final authenticateWithBiometricAction = Atom.action();
final logoutAction = Atom.action();

class AuthLogic extends Reducer {
  final IAuthWithEmailAndPasswordService authWithEmailAndPasswordService;
  final LocalAuthBiometricsService localAuthBiometricsService;

  AuthLogic(this.authWithEmailAndPasswordService, this.localAuthBiometricsService) {
    on(() => [checkAuthAction], checkAuth);
    on(() => [signInWithEmailAndPasswordAction], signInWithEmailAndPassword);
    on(() => [createWithEmailAndPasswordAction], createWithEmailAndPassword);
    on(() => [authenticateWithBiometricAction], authenticateWithBiometric);
    on(() => [logoutAction], logout);
  }

  Future<void> checkAuth() async {
    startLoadingAction.call();

    if (isFirstTimeInAppState.value) {
      return;
    }
    final user = await authWithEmailAndPasswordService.currentUser;
    if (user != null) {
      allow(user);
    } else {
      dissmiss();
      await checkBiometricAuth();
    }
    stopLoadingAction.call();
  }

  Future<void> checkBiometricAuth() async {
    isAvailableAuthByBiometric.value = await localAuthBiometricsService.isBiometricAvailable();
  }

  Future<void> authenticateWithBiometric() async {
    startLoadingAction.call();
    if (!isAvailableAuthByBiometric.value) return;
    final isAuthenticated = await localAuthBiometricsService.authenticate();
    if (!isAuthenticated) return;
    final dataUser = await AppPreferences.getUserCredential();
    final userCredential = SignInDTO(email: dataUser['emailAdress']!, password: dataUser['securePassword']!);
    signInWithEmailAndPasswordAction.value = userCredential;
    stopLoadingAction.call();
  }

  Future<void> signInWithEmailAndPassword() async {
    startLoadingAction.call();

    final credential = signInWithEmailAndPasswordAction.value!;
    final String email = credential.email;
    final String password = credential.password;

    final result = await authWithEmailAndPasswordService.loginWithEmailAndPassword(email, password);
    result.fold((status) {
      if (status) {
        allow(authWithEmailAndPasswordService.currentUser!);
      }
    }, (error) async {
      log(error.toString());
      showAuthErrorAtom.value = true;
      authErrorMessage.value = "Invalid credentials. Please check your email and password.";
      dissmiss();
    });

    stopLoadingAction.call();
  }

  Future<void> createWithEmailAndPassword() async {
    startLoadingAction.call();
    final credential = createWithEmailAndPasswordAction.value!;
    final String name = credential.name;
    final String email = credential.email;
    final String password = credential.password;

    final result = await authWithEmailAndPasswordService.createWithEmailAndPassword(name, email, password);
    result.fold((status) async {
      if (status) {
        allow(authWithEmailAndPasswordService.currentUser!);
        await AppPreferences.addUserCredential(email, password);
        await AppPreferences.enableFirstRecord(false);
      }
    }, (error) {
      log(error.toString());
      showAuthErrorAtom.value = true;
      authErrorMessage.value = "Error in create user, Try Again.";
      dissmiss();
    });

    stopLoadingAction.call();
  }

  Future<void> logout() async {
    startLoadingAction.call();

    final result = await authWithEmailAndPasswordService.logout();
    result.fold((status) => dissmiss(), (error) => null);

    stopLoadingAction.call();
  }

  void allow(UserEntity user) {
    isAuthenticatedAtom.value = AuthState.logged;
    currentUserAtom.value = user;
  }

  void dissmiss() {
    isAuthenticatedAtom.value = AuthState.unlogged;
    currentUserAtom.value = null;
  }
}
