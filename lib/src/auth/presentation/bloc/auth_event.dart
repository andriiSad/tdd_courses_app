part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password, fullName];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({
    required this.email,
  });

  final String email;

  @override
  List<String> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.userData,
    required this.action,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be either String or File, '
          'received ${userData.runtimeType}',
        );

  final dynamic userData;
  final UpdateUserAction action;

  @override
  List<Object?> get props => [userData, action];
}

class SignOutEvent extends AuthEvent {}
