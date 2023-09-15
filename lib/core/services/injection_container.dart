import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_courses_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_courses_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_courses_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  //use registerFactory for registering blocs
  //use registerLazySingleton for registering dependencies
  //we always start from top, from blocs
  // Feature  => OnBoarding
  serviceLocator
    //Buisness Logic
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: serviceLocator(),
        checkIfUserIsFirstTimer: serviceLocator(),
      ),
    )

    //Use cases
    ..registerLazySingleton(() => CacheFirstTimer(serviceLocator()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(serviceLocator()))

    //Repositories
    ..registerLazySingleton<IOnBoardingRepo>(
      () => OnBoardingRepoImpl(serviceLocator()),
    )

    //Data Sources
    ..registerLazySingleton<IOnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(serviceLocator()),
    )

    //External Dependencies
    ..registerLazySingleton(
      () => prefs,
    );
}
