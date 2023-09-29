import 'package:elevo/src/domain/entity/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthWithEmailAndPasswordService {
  UserEntity? get currentUser;
  Future<Result<bool, Exception>> loginWithEmailAndPassword(String email, String password);
  Future<Result<bool, Exception>> createWithEmailAndPassword(String name, String email, String password);
  Future<Result<bool, Exception>> logout();
}
