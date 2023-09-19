import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_courses_app/core/errors/exceptions.dart';
import 'package:tdd_courses_app/core/utils/constants.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = '_mock.uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late FirebaseStorage dbClient;

  late IAuthRemoteDataSource dataSource;
  late DocumentReference<DataMap> documentReference;
  late UserCredential userCredential;
  late MockUser mockUser;

  const tUser = LocalUserModel.empty();

  setUp(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    dbClient = MockFirebaseStorage();

    //get doc ref, but not putting anything there
    documentReference = cloudStoreClient.collection('users').doc();

    //put into cloud store tUser, but with uid: documentReference.id
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );

    mockUser = MockUser()..uid = documentReference.id;

    userCredential = MockUserCredential(mockUser);

    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );

    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  const tPassword = '_test.password';
  const tFullName = '_test.fullName';
  const tEmail = '_test.email';
  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user_not_found',
    message:
        'There is no user record, corresponding to the provided identifier.',
  );

  group('forgotPassword', () {
    test(
      'should complete successfully, when no exception is thrown',
      () async {
        // arrange
        when(
          () => authClient.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => Future.value());

        // act
        final call = dataSource.forgotPassword(email: tEmail);

        // assert
        expect(call, completes);

        verify(
          () => authClient.sendPasswordResetEmail(
            email: tEmail,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException], '
      'when authClent.sendPasswordResetEmail throws [FirebaseAuthException]',
      () async {
        // arrange
        when(
          () => authClient.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenThrow(tFirebaseAuthException);

        // act
        final call = dataSource.forgotPassword;

        // assert
        expect(
          () => call(email: tEmail),
          throwsA(
            ServerException(
              statusCode: tFirebaseAuthException.code,
              message: tFirebaseAuthException.message!,
            ),
          ),
        );

        verify(
          () => authClient.sendPasswordResetEmail(
            email: tEmail,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('signIn', () {
    test(
      'should return [LocalUserModel] '
      'when no exception is thrown',
      () async {
        //arrange
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);

        //act
        final result = await dataSource.signIn(
          email: tEmail,
          password: tPassword,
        );

        // assert
        expect(
          result.uid,
          userCredential.user!.uid,
        );

        expect(result.points, tUser.points);

        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException] '
      'when authClent throws [FirebaseAuthException]',
      () async {
        //arrange
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        //act
        final call = dataSource.signIn;

        // assert
        expect(
          () => call(
            email: tEmail,
            password: tPassword,
          ),
          throwsA(
            ServerException(
              statusCode: tFirebaseAuthException.code,
              message: tFirebaseAuthException.message!,
            ),
          ),
        );

        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException] '
      'when user is null after signing in',
      () async {
        //arrange
        final emptyUserCredential = MockUserCredential();
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);

        //act
        final call = dataSource.signIn;

        // assert
        expect(
          () => call(
            email: tEmail,
            password: tPassword,
          ),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
  });
  group('signUp', () {
    test(
      'should complete successfully, '
      'when no exception is thrown',
      () async {
        //arrange
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);

        when(() => userCredential.user!.updateDisplayName(any())).thenAnswer(
          (_) async => Future.value(),
        );
        when(() => userCredential.user!.updatePhotoURL(any())).thenAnswer(
          (_) async => Future.value(),
        );

        //act
        final call = dataSource.signUp(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        );

        // assert
        expect(
          call,
          completes,
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        await untilCalled(() => userCredential.user!.updateDisplayName(any()));
        await untilCalled(() => userCredential.user!.updatePhotoURL(any()));

        verify(() => userCredential.user!.updateDisplayName(tFullName))
            .called(1);
        verify(() => userCredential.user!.updatePhotoURL(kDefaultAvatar))
            .called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException] '
      'when authClient throws [FirebaseAuthException]',
      () async {
        //arrange
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        //act
        final call = dataSource.signUp;

        // assert
        expect(
          () => call(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
          throwsA(
            ServerException(
              statusCode: tFirebaseAuthException.code,
              message: tFirebaseAuthException.message!,
            ),
          ),
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
  });
}
