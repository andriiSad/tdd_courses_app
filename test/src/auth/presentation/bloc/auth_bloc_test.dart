import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/core/errors/failures.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/sign_in.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/sign_up.dart';
import 'package:tdd_courses_app/src/auth/domain/usecases/update_user.dart';
import 'package:tdd_courses_app/src/auth/presentation/bloc/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const tSignInParams = SignInParams.empty();
  const tSignUpParams = SignUpParams.empty();
  const tForgotPasswordParams = ForgotPasswordParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();

  const tFailure = ServerFailure(
    message: 'Unknown failure',
    statusCode: 505,
  );

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();

    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tForgotPasswordParams);
    registerFallbackValue(tUpdateUserParams);
  });
  //always close the bloc
  tearDown(() => authBloc.close());

  test(
    'initial state should be [AuthInitial]',
    () async => expect(authBloc.state, const AuthInitial()),
  );

  group('SignInEvent', () {
    const tUser = LocalUser.empty();
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedIn] '
      'when [SignInEvent] is added',
      build: () {
        when(
          () => signIn(
            any(),
          ),
        ).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(signIn);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] '
      'when signIn returns a failure',
      build: () {
        when(
          () => signIn(
            any(),
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => signIn(
            tSignInParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(signIn);
      },
    );
  });
  group('SignUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUp] '
      'when [SignUpEvent] is added',
      build: () {
        when(
          () => signUp(
            any(),
          ),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedUp(),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(signUp);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] '
      'when signUp returns a failure',
      build: () {
        when(
          () => signUp(
            any(),
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => signUp(
            tSignUpParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(signUp);
      },
    );
  });
  group('ForgotPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, ForgotPasswordSent] '
      'when [ForgotPasswordEvent] is added',
      build: () {
        when(
          () => forgotPassword(
            any(),
          ),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        ForgotPasswordEvent(
          email: tForgotPasswordParams.email,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(
            tForgotPasswordParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(forgotPassword);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] '
      'when forgotPassword returns a failure',
      build: () {
        when(
          () => forgotPassword(
            any(),
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        ForgotPasswordEvent(
          email: tSignUpParams.email,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(
            tForgotPasswordParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });
  group('UpdateUserEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserUpdated] '
      'when [UpdateUserEvent] is added',
      build: () {
        when(
          () => updateUser(
            any(),
          ),
        ).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          userData: tUpdateUserParams.userData,
          action: tUpdateUserParams.action,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
      ],
      verify: (_) {
        verify(
          () => updateUser(
            tUpdateUserParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(updateUser);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] '
      'when updateUser returns a failure',
      build: () {
        when(
          () => updateUser(
            any(),
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          userData: tUpdateUserParams.userData,
          action: tUpdateUserParams.action,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tFailure.message),
      ],
      verify: (_) {
        verify(
          () => updateUser(
            tUpdateUserParams,
          ),
        ).called(1);

        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}
