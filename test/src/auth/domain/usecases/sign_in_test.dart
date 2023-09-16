import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/sign_in.dart';

import 'auth_repo.mock.dart';

void main() {
  late IAuthRepo repository;
  late SignIn usecase;

  const tUser = LocalUser.empty();
  const params = SignInParams.empty();

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignIn(repository);
  });

  test(
    'should call the [AuthRepo.signIn] '
    'and return [LocalUser] if successfull',
    () async {
      // arrange
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right<dynamic, LocalUser>(tUser));

      verify(
        () => repository.signIn(
          email: params.email,
          password: params.password,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
