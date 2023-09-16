import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/sign_up.dart';

import 'auth_repo.mock.dart';

void main() {
  late IAuthRepo repository;
  late SignUp usecase;

  const params = SignUpParams.empty();

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignUp(repository);
  });

  test(
    'should call the [AuthRepo.signUp]',
    () async {
      // arrange
      when(
        () => repository.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          fullName: any(named: 'fullName'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.signUp(
          email: params.email,
          password: params.password,
          fullName: params.fullName,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
