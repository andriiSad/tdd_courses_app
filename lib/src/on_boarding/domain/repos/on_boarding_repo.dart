import 'package:tdd_courses_app/core/utils/typedefs.dart';

abstract class IOnBoardingRepo {
  ResultVoid cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
