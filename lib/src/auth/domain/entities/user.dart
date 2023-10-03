import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.groupIds = const [],
    this.enrolledCoursesId = const [],
    this.following = const [],
    this.followers = const [],
    this.prifilePic,
    this.bio,
  });

  const LocalUser.empty()
      : this(
          uid: '_empty.uid',
          email: '_empty.email',
          points: 0,
          fullName: '_empty.fullName',
        );

  final String uid;
  final String email;
  final String? prifilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCoursesId;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [
        uid,
        email,
        points,
        fullName,
        groupIds,
        enrolledCoursesId,
        following,
        followers,
        prifilePic,
        bio,
      ];

  @override
  String toString() => 'LocalUser { uid: $uid, email: $email, bio: $bio, '
      'fullName: $fullName, points: $points,}';
}
