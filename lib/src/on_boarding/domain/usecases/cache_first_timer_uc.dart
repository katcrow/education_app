import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

/// usecase 는 하나의 책임만 존재
/// 파라미터 있는지 없는지 core 폴더에 기본 use case 만들어 상속 받아 사용

class CacheFirstTimerUc extends UsecaseWithoutParams<void> {
  const CacheFirstTimerUc(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}
