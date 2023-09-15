import 'package:equatable/equatable.dart';
import 'package:tdd_courses_app/core/res/media_resources.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.lottie,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          lottie: MediaRes.casualReadLottie,
          title: 'Brand new curriculum',
          description: 'This is the first online educational platform '
              " designed by the world's top professors",
        );
  const PageContent.second()
      : this(
          lottie: MediaRes.casualReadSitLottie,
          title: 'Brand a fun atmosphere',
          description: 'This is the first online educational platform '
              " designed by the world's top professors",
        );
  const PageContent.third()
      : this(
          lottie: MediaRes.casualMeditationLottie,
          title: 'Easy to join the lesson',
          description: 'This is the first online educational platform '
              " designed by the world's top professors",
        );

  final String lottie;
  final String title;
  final String description;

  @override
  List<String?> get props => [lottie, title, description];
}
