import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimerUc {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserFirstTimerUc {}

void main() {
  late CacheFirstTimerUc cacheFirstTimer;
  late CheckIfUserFirstTimerUc checkIfUserFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimerUc: cacheFirstTimer,
      checkIfUserFirstTimerUc: checkIfUserFirstTimer,
    );
  });

  final tFailure = CacheFailure(
    message: 'Insufficient storage Permissions',
    statusCode: 4032,
  );

  test(
    'initial state should be [OnBoardingInitial] ',
    () {
      expect(
        cubit.state,
        const OnBoardingInitial(),
      );
    },
  );

  group(
    'cacheFirstTimer',
    () {
      blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CachingFirstTimer, UserCached] when successful',
        build: () {
          when(() => cacheFirstTimer()).thenAnswer(
            (_) async => const Right(null),
          );
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => const [
          CachingFirstTimer(),
          UserCached(),
        ],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        },
      );

      blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit '
        '[CheckIfUserFirstTimer, OnBoardingError] when unsuccessful',
        build: () {
          when(() => cacheFirstTimer()).thenAnswer(
            (_) async => Left(tFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => [
          const CachingFirstTimer(),
          OnBoardingError(tFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        },
      );
    },
  );

  group(
    'checkIfUserFirstTimer',
    () {
      blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
        'when successful',
        build: () {
          when(() => checkIfUserFirstTimer()).thenAnswer(
            (_) async => const Right(false),
          );
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserFirstTimer(),
        expect: () => const [
          CheckingIfUserIsFirstTimer(),
          OnBoardingStatus(isFirstTimer: false),
        ],
        verify: (_) {
          verify(() => checkIfUserFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserFirstTimer);
        },
      );

      //-----
      blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CheckingIfUserIsFirstTimer, OnBoardingState(true)] '
        'when unsuccessful',
        build: () {
          when(() => checkIfUserFirstTimer()).thenAnswer(
            (_) async => Left(tFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserFirstTimer(),
        expect: () => const [
          CheckingIfUserIsFirstTimer(),
          OnBoardingStatus(isFirstTimer: true),
        ],
        verify: (_) {
          verify(() => checkIfUserFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserFirstTimer);
        },
      );
    },
  );
}
