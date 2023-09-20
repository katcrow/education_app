import 'package:education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  /// 사용자가 처음 로그인 했는지 여부
  /// 처음 : 온보딩 , 두번째이상 : 로그인,
  /// 각각 use case 가 있어야 한다.
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserFirstTimer();
}
