import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/forgot_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late IAuthRepo repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = ForgotPassword(repository);
  });

  const params = ForgotPasswordParams.empty();

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      // arrange
      when(
        () => repository.forgotPassword(
          email: any(named: 'email'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right<dynamic, void>(null));
      verify(
        () => repository.forgotPassword(
          email: params.email,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
