import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = LocalUserModel.empty();

  final tJson = fixture('user.json');

  final tMap = jsonDecode(tJson) as DataMap;

  test(
    'should be subclass of User',
    () {
      // assert
      expect(tModel, isA<LocalUser>());
    },
  );
  group('fromMap', () {
    test(
      'should return a [LocalUserModel] with the right data',
      () {
        // act
        final result = LocalUserModel.fromMap(tMap);

        // assert
        //check is that the result is a [LocalUserModel] not [LocalUser] entity
        expect(result, isA<LocalUserModel>());
        expect(result, tModel);
      },
    );
    //ADDITIONAL TEST
    test(
      'should throw an [Error] when the map is invalid',
      () {
        // arrange
        final map = DataMap.from(tMap)..remove('uid');

        // act
        const methodCall = LocalUserModel.fromMap;

        // assert
        expect(() => methodCall(map), throwsA(isA<Error>()));
      },
    );
  });
  group('toMap', () {
    test(
      'should return a valid DataMap',
      () {
        // act
        final result = tModel.toMap();

        // assert
        expect(result, tMap);
        // expect(result['id'], tModel.id);
        // expect(result['createdAt'], tModel.createdAt);
        // expect(result['name'], tModel.name);
        // expect(result['avatar'], tModel.avatar);
      },
    );
  });
  group('copyWith', () {
    test('should create a new [LocalUserModel] with updated fields', () {
      //arrange
      const updatedFullName = '_updated.fullName';

      //act
      final updatedModel = tModel.copyWith(fullName: updatedFullName);

      //expect
      expect(updatedModel, isNot(same(tModel)));
      expect(updatedModel.fullName, updatedFullName);
      expect(updatedModel.uid, tModel.uid);
      expect(updatedModel.email, tModel.email);
      expect(updatedModel.points, tModel.points);
    });
  });
}
