import 'package:tdd_courses_app/core/usecases/usecases.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';

class SignOut extends UsecaseWithOutParams<void> {
  const SignOut(this._repository);

  final IAuthRepo _repository;

  @override
  ResultVoid call() async => _repository.signOut();
}
