import 'package:equatable/equatable.dart';
import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/core/usecases/usecases.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/domain/repos/auth_repo.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);

  final IAuthRepo _repository;

  @override
  ResultVoid call(
    UpdateUserParams params,
  ) async =>
      _repository.updateUser(
        userData: params.userData,
        action: params.action,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userData,
    required this.action,
  });

  const UpdateUserParams.empty()
      : this(
          userData: '_empty.userData',
          action: UpdateUserAction.displayName,
        );

  final dynamic userData;
  final UpdateUserAction action;

  @override
  List<Object?> get props => [userData, action];
}
