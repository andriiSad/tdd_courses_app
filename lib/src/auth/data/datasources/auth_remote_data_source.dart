import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> forgotPassword({
    required String email,
  });
  Future<void> updateUser({
    required dynamic userData,
    required UpdateUserAction action,
  });
  Future<void> signOut();
}

class AuthDataSourceImpl implements IAuthRemoteDataSource {
  @override
  Future<void> forgotPassword({
    required String email,
  }) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
