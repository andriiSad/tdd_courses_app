import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    required this.groupIds,
    required this.enrolledCoursesId,
    required this.following,
    required this.followers,
    this.prifilePic,
    this.bio,
  });

  const LocalUser.empty()
      : this(
          uid: '_empty_uid',
          email: '_empty_email',
          points: 0,
          fullName: '_fullName',
          groupIds: const [],
          enrolledCoursesId: const [],
          following: const [],
          followers: const [],
          prifilePic: '_empty_profilePic',
          bio: '_empty_bio',
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
  List<String> get props => [uid, email];

  @override
  String toString() => 'LocalUser { uid: $uid, email: $email, bio: $bio, '
      'fullName: $fullName, points: $points,}';
}
