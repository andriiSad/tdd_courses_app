import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_courses_app/core/errors/exceptions.dart';

abstract class IOnBoardingLocalDataSource {
  const IOnBoardingLocalDataSource();

  //no Either return types, datasources throws an error
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class OnBoardingLocalDataSourceImpl implements IOnBoardingLocalDataSource {
  OnBoardingLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    // Store a boolean value to indicate that the user
    //has completed onboarding
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    // Retrieve the boolean value to check if the user is a first-timer
    // Default to true if the value is not found
    try {
      return _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
