import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/usecases/cache_first_timer.dart';

import 'on_boarding_repo_mock.dart';

void main() {
  late IOnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(
    () => {
      repo = MockOnBoardingRepo(),
      usecase = CacheFirstTimer(repo),
    },
  );

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer]',
    () async {
      // arrange
      when(() => repo.cacheFirstTimer())
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase();
      // assert

      expect(result, const Right<dynamic, void>(null));

      verify(() => repo.cacheFirstTimer()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
