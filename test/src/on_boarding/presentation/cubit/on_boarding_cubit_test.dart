import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/core/errors/failures.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_courses_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late final CacheFirstTimer cacheFirstTimerMock;
  late final CheckIfUserIsFirstTimer checkIfUserIsFirstTimerMock;
  late final OnBoardingCubit cubit;

  const tErrorMessage = 'Setting a bool failed';

  setUp(() {
    cacheFirstTimerMock = MockCacheFirstTimer();
    checkIfUserIsFirstTimerMock = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimerMock,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimerMock,
    );
  });

  //ALWAYS CLOSE BLOC/CUBIT AFTER EACH TEST
  tearDown(() => cubit.close());

  test(
    'initial state should be [OnBoardingInitial]',
    () async => expect(cubit.state, const OnBoardingInitial()),
  );

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, UserCached] '
      'when cacheFirstTimer successfull',
      build: () {
        when(() => cacheFirstTimerMock())
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const <OnBoardingState>[
        CachingFirstTimer(),
        UserCached(),
      ],
    );
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingError] '
      'when cacheFirstTimer unsuccessfull',
      build: () {
        when(() => cacheFirstTimerMock()).thenAnswer(
          (_) async => const Left(CacheFailure(message: tErrorMessage)),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const <OnBoardingState>[
        CachingFirstTimer(),
        OnBoardingError(message: tErrorMessage),
      ],
    );
  });
  // group('checkIfUserIsFirstTimer', () {
  //   blocTest<OnBoardingCubit, OnBoardingState>(
  //     'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
  //     'with isFirstTimer true when user is a first timer',
  //     build: () {
  //       when(() => checkIfUserIsFirstTimerMock.call())
  //           .thenAnswer((_) async => const Right(true));
  //       return cubit;
  //     },
  //     act: (cubit) => cubit.checkIfUserIsFirstTimer(),
  //     expect: () => <OnBoardingState>[
  //       const CheckingIfUserIsFirstTimer(),
  //       const OnBoardingStatus(isFirstTimer: true),
  //     ],
  //   );

  //   blocTest<OnBoardingCubit, OnBoardingState>(
  //     'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
  //     'with isFirstTimer false when user is not a first timer',
  //     build: () {
  //       when(() => checkIfUserIsFirstTimerMock())
  //           .thenAnswer((_) async => const Right(false));
  //       return cubit;
  //     },
  //     act: (cubit) => cubit.checkIfUserIsFirstTimer(),
  //     expect: () => <OnBoardingState>[
  //       const CheckingIfUserIsFirstTimer(),
  //       const OnBoardingStatus(isFirstTimer: false),
  //     ],
  //   );

  //   blocTest<OnBoardingCubit, OnBoardingState>(
  //     'should emit [CheckingIfUserIsFirstTimer, OnBoardingError] '
  //     'when an error occurs during user status check',
  //     build: () {
  //       when(() => checkIfUserIsFirstTimerMock()).thenAnswer(
  //         (_) async => const Left(
  //           CacheFailure(message: 'Some error message'),
  //         ),
  //       );
  //       return cubit;
  //     },
  //     act: (cubit) => cubit.checkIfUserIsFirstTimer(),
  //     expect: () => <OnBoardingState>[
  //       const CheckingIfUserIsFirstTimer(),
  //       const OnBoardingError(message: 'Some error message'),
  //     ],
  //   );
  // });
}
