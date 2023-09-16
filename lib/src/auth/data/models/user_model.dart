import 'package:tdd_courses_app/core/utils/typedefs.dart';
import 'package:tdd_courses_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCoursesId,
    super.following,
    super.followers,
    super.prifilePic,
    super.bio,
  });

  const LocalUserModel.empty() : super.empty();

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
          //Also we can cast like this:
          enrolledCoursesId: List<String>.from(
            map['enrolledCoursesId'] as List<dynamic>,
          ),
          following: (map['following'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          prifilePic: map['prifilePic'] as String?,
          bio: map['bio'] as String?,
        );

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'points': points,
        'fullName': fullName,
        'groupIds': groupIds,
        'enrolledCoursesId': enrolledCoursesId,
        'following': following,
        'followers': followers,
        'prifilePic': prifilePic,
        'bio': bio,
      };
  LocalUserModel copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCoursesId,
    List<String>? following,
    List<String>? followers,
    String? prifilePic,
    String? bio,
  }) =>
      LocalUserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        points: points ?? this.points,
        fullName: fullName ?? this.fullName,
        groupIds: groupIds ?? this.groupIds,
        enrolledCoursesId: enrolledCoursesId ?? this.enrolledCoursesId,
        following: following ?? this.following,
        followers: followers ?? this.followers,
        prifilePic: prifilePic ?? this.prifilePic,
        bio: bio ?? this.bio,
      );
}
