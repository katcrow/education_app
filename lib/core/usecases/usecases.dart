import 'package:education_app/core/utils/typedefs.dart';

// 1. 파라미터 있음
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

// 2. 파라미터 없음
abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
