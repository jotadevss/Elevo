import 'package:elevo/src/domain/entity/user.dart';
import 'package:elevo/src/infra/services/auth/interface_auth_with_email_and_password_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';

class FirebaseAuthService implements IAuthWithEmailAndPasswordService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  UserEntity? get currentUser {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final user = UserEntity(uid: firebaseUser.uid, name: firebaseUser.displayName ?? "User", email: firebaseUser.email!);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<Result<bool, Exception>> loginWithEmailAndPassword(String email, String password) async {
    try {
      final isSigned = await _auth.signInWithEmailAndPassword(email: email, password: password).then((_) => true);
      return Success(isSigned);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool, Exception>> createWithEmailAndPassword(String name, String email, String password) async {
    try {
      final isCreated = await _auth.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) async {
        // Encrypt password
        return await userCredential.user!.updateDisplayName(name).then((_) => true);
      });
      return Success(isCreated);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool, Exception>> logout() async {
    try {
      final isSignouted = await _auth.signOut().then((_) => true);
      return Success(isSignouted);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
