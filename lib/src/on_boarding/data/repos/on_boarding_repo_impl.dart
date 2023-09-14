import 'package:dartz/dartz.dart';
import 'package:tdd_courses_app/core/errors/exceptions.dart';
import 'package:tdd_courses_app/core/errors/failures.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

//In repo implementation we just call the datasource,
//catch the Exceptions and return Failures
class OnBoardingRepoImpl implements IOnBoardingRepo {
  const OnBoardingRepoImpl(this._localDataSource);

  final IOnBoardingLocalDataSource _localDataSource;

  @override
  ResultVoid cacheFirstTimer() async {
    try {
      //we should await here!!!
      await _localDataSource.cacheFirstTimer();
    } on CacheException catch (e) {
      return Left<Failure, dynamic>(CacheFailure.fromException(e));
    }
    return const Right(null);
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left<Failure, bool>(CacheFailure.fromException(e));
    }
  }
}
