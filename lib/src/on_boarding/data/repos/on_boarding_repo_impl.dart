import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter/material.dart';

/// OnBoardingRepo -> abstract class -> implements?
class OnBoardingRepoImpl implements OnBoardingRepo {
  // constructor -> Impl 이니까 dara source 가 필요. Dependency api?
  const OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint(e.message);
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
}
