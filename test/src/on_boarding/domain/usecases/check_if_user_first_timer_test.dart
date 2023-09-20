import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_first_timer_uc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'on_boarding_repo.mock.dart';

/// 단위 테스트
/// 1. What does the class depend on? (클래스는 무엇에 의존합니까?)
///     answer --> OnBoardingRepo
/// 2. How can we create a fake version of the dependency?(의존성의 가짜 버전을 어떻게 만들 수 있습니까?)
///     answer --> use mocktail
/// 3. How do we control what out dependencies do? (우리의 의존성이 무엇을 하는지 어떻게 제어합니까?)
///     answer --> using the mocktail's APIs
///     *** 종속된 클래스 한번만 호출하는 마지막 체크

void main() {
  //-- 1. 각 클래스 선언
  late OnBoardingRepo repo;
  late CheckIfUserFirstTimerUc usecase;

  //-- 2. init
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserFirstTimerUc(repo); // important
  });

  //-- 3. dispose : 필요 시

  //-- 4. test start
  test(
      'should call the [OnBoarding.checkIfUserFirstTimer '
      'and return the right data', () async {
    // arrange : when()
    when(() => repo.checkIfUserFirstTimer()).thenAnswer(
      (_) async => const Right(true),
    );

    // act : result
    final result = await usecase();

    // assert : expect()
    expect(
      result,
      equals(
        const Right<dynamic, bool>(true),
      ),
    );
    verify(() => repo.checkIfUserFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
