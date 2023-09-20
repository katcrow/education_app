import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  // Feature -> onBoarding
  // business logic
  // registerFactory -> 함수 등록
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimerUc: sl(),
        checkIfUserFirstTimerUc: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimerUc(sl()))
    ..registerLazySingleton(() => CheckIfUserFirstTimerUc(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
// ..registerLazySingleton(() => prefs);

///  cubit- -> use case --> <Repo>RepoImpl --> <dataSource>DaraSrcImpl --> DB
