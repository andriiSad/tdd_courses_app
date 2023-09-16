import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/sign_out.dart';

import 'auth_repo.mock.dart';

void main() {
  late IAuthRepo repository;
  late SignOut usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignOut(repository);
  });

  test(
    'should call the [AuthRepo.signOut]',
    () async {
      // arrange
      when(
        () => repository.signOut(),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase();

      // assert
      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.signOut(),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
