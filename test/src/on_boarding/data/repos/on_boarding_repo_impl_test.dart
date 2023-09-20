import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  //-- 1. 각 클래스 선언
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  //-- 2. init
  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  //-- 3. dispose

  //-- 4. test start
  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test(
        'should complete successfully when call to local source is successful ',
        () async {
      // arrange : when()
      when(() => localDataSource.cacheFirstTimer())
          .thenAnswer((_) => Future.value());

      // act
      final result = await repoImpl.cacheFirstTimer();

      // assert : expect
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );
      verify(() => localDataSource.cacheFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return [CacheFailure] when call to local source '
        'is unsuccessful', () async {
      // arrange : when()
      when(() => localDataSource.cacheFirstTimer()).thenThrow(
        (_) => const CacheException(
          message: 'Insufficient storage',
        ),
      );

      // act
      final result = await repoImpl.cacheFirstTimer();

      // assert : expect
      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(
              message: 'Insufficient storage',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => localDataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('checkIfUserFirstTimer', () {
    test('should return true when user is first timer ', () async {
      // arrange : when()
      when(() => localDataSource.checkIfUserFirstTimer())
          .thenAnswer((_) => Future.value(true));

      // act
      final result = await repoImpl.checkIfUserFirstTimer();

      // assert : expect
      expect(
        result,
        equals(
          const Right<dynamic, bool>(true),
        ),
      );
      verify(() => localDataSource.checkIfUserFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return false when user is first timer ', () async {
      // arrange : when()
      when(() => localDataSource.checkIfUserFirstTimer())
          .thenAnswer((_) => Future.value(false));

      // act
      final result = await repoImpl.checkIfUserFirstTimer();

      // assert : expect
      expect(
        result,
        equals(
          const Right<dynamic, bool>(false),
        ),
      );
      verify(() => localDataSource.checkIfUserFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return [CheckIfUserFirstTimer] when call to local source '
        'is unsuccessful', () async {
      // arrange : when()
      when(() => localDataSource.checkIfUserFirstTimer()).thenThrow(
        (_) => const CacheException(
          message: 'Insufficient storage',
          statusCode: 403,
        ),
      );

      // act
      final result = await repoImpl.checkIfUserFirstTimer();

      // assert : expect
      expect(
        result,
        equals(
          Left<CacheFailure, bool>(
            CacheFailure(
              message: 'Insufficient storage',
              statusCode: 403,
            ),
          ),
        ),
      );
      verify(() => localDataSource.checkIfUserFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
