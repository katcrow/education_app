import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_first_timer_uc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

/// bloc or cubit 은 presentation 영역이다.
/// 따라서, domain 영역의 use case를 참조한다.
class OnBoardingCubit extends Cubit<OnBoardingState> {
  // constructor, setUp, Init
  OnBoardingCubit({
    required CacheFirstTimerUc cacheFirstTimerUc,
    required CheckIfUserFirstTimerUc checkIfUserFirstTimerUc,
  })  : _cacheFirstTimerUc = cacheFirstTimerUc,
        _checkIfUserFirstTimerUc = checkIfUserFirstTimerUc,
        super(const OnBoardingInitial()); // state 초기화
  // use case
  final CacheFirstTimerUc _cacheFirstTimerUc;
  final CheckIfUserFirstTimerUc _checkIfUserFirstTimerUc;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimerUc();
    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserFirstTimerUc();
    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
