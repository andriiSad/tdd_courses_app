import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:tdd_courses_app/src/auth/data/datasources/auth_remote_data_source.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;

  late IAuthRemoteDataSource dataSource;

  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final mockUser = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    authClient = MockFirebaseAuth(mockUser: mockUser);

    final result = await authClient.signInWithCredential(credential);

    final user = result.user;

    dbClient = MockFirebaseStorage();

    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  const tPassword = '_test.password';
  const tFullName = '_test.fullName';
  const tEmail = '_test.email';

  test(
    'signUp',
    () async {
      // act
      await dataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      );

      final user = await cloudStoreClient
          .collection('users')
          .doc(
            authClient.currentUser!.uid,
          )
          .get();

      // assert
      //expect that the user was created in the firestore and the authClient
      //also has this user
      expect(authClient.currentUser, isNotNull);
      expect(authClient.currentUser!.displayName, tFullName);
      expect(authClient.currentUser!.email, tEmail);

      expect(user.exists, isTrue);
    },
  );
  test(
    'signIn',
    () async {
      // act
      //we need to create a user first, or mockUser will be used
      await dataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      );

      //setting currentUser to null
      await authClient.signOut();

      await dataSource.signIn(
        email: tEmail,
        password: tPassword,
      );
      // assert
      expect(authClient.currentUser, isNotNull);
      expect(authClient.currentUser!.email, tEmail);
    },
  );
}
