import 'package:dartz/dartz.dart';
import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/core/errors/exceptions.dart';
import 'package:tdd_courses_app/core/errors/failures.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements IAuthRepo {
  const AuthRepoImpl(this._remoteDataSource);
  final IAuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid forgotPassword({
    required String email,
  }) async {
    try {
      await _remoteDataSource.forgotPassword(
        email: email,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
