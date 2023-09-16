import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/update_user.dart';

import 'auth_repo.mock.dart';

void main() {
  late IAuthRepo repository;
  late UpdateUser usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);

    registerFallbackValue(UpdateUserAction.empty);
  });

  const params = UpdateUserParams.empty();

  test(
    'should call the [AuthRepo.updateUser]',
    () async {
      // arrange
      when(
        () => repository.updateUser(
          userData: any<dynamic>(named: 'userData'),
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      // assert
      expect(result, const Right<dynamic, void>(null));
      verify(
        () => repository.updateUser(
          userData: params.userData,
          action: params.action,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
