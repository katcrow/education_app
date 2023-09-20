import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  //-- 1. 각 클래스 선언
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  //-- 2. init
  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSrcImpl(prefs);
  });

  //-- 3. dispose

  //-- 4. test start
  test(
    'should be a subclass of [OnBoardingLocalDataSource]',
    () {
      expect(localDataSource, isA<OnBoardingLocalDataSource>());
    },
  );

  group(
    'cacheFirstTimer',
    () {
      test('should call [SharedPreferences] to cache the data ', () async {
        // arrange : when()
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);
        // act
        await localDataSource.cacheFirstTimer();
        // // check if it actually saved
        // // 아직 로컬DB에 저장이 안되어 있으므로 null 반환
        // final result = prefs.getBool(kFirstTimerKey);
        // expect(result, false);
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      });

      test(
        'should throw a [CacheException] when there is '
        'an error caching the data',
        () async {
          when(() => prefs.setBool(any(), any())).thenThrow(Exception());
          final methodCall = localDataSource.cacheFirstTimer();
          expect(methodCall, throwsA(isA<CacheException>()));
          verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should call [SharedPreferences] to check if user is first '
        'timer and return the right response from storage when data exists',
        () async {
          //-- 1.arrange
          when(() => prefs.getBool(any())).thenReturn(false);
          //-- 2.act
          final result = await localDataSource.checkIfUserFirstTimer();
          //-- 3.assert
          expect(result, false);
          verify(() => prefs.getBool(kFirstTimerKey)).called(1);
          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'should return true if there is no data in storage',
        () async {
          //-- 1.arrange
          when(() => prefs.getBool(any())).thenReturn(null);
          //-- 2.act
          final result = await localDataSource.checkIfUserFirstTimer();
          //-- 3.assert
          expect(result, true);
          verify(() => prefs.getBool(kFirstTimerKey)).called(1);
          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'should throw a [CacheException] when there is an error '
        'retrieving the data',
        () async {
          //-- 1.arrange
          when(() => prefs.getBool(any())).thenThrow(Exception());
          //-- 2.act
          final methodCall = localDataSource.checkIfUserFirstTimer();
          //-- 3.assert
          expect(methodCall, throwsA(isA<CacheException>()));
          verify(() => prefs.getBool(kFirstTimerKey)).called(1);
          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );
}
