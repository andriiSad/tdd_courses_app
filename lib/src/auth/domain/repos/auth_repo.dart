import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';

abstract class IAuthRepo {
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultVoid signUp({
    required String email,
    required String password,
    required String fullName,
  });

  ResultVoid forgotPassword({
    required String email,
  });

  ResultVoid updateUser({
    required dynamic userData,
    required UpdateUserAction action,
  });

  ResultVoid signOut();
}
