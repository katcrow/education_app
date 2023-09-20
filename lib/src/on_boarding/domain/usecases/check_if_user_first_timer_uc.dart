import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

/// usecase 는 하나의 책임만 있습니다.
/// 파라미터가 있는지 없는지를 core에 기본 usecase를 만들어 상속받아 사용합니다.

class CheckIfUserFirstTimerUc extends UsecaseWithoutParams<bool> {
  const CheckIfUserFirstTimerUc(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() async => _repo.checkIfUserFirstTimer();
}
