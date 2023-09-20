import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContentEnt extends Equatable {
  // constructor
  const PageContentEnt({
    required this.image,
    required this.title,
    required this.description,
  });

  // named constructor
  const PageContentEnt.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed '
              "by the world's top professors ",
        );
  const PageContentEnt.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description: 'This is the first online education platform designed '
              "by the world's top professors ",
        );
  const PageContentEnt.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description: 'This is the first online education platform designed '
              "by the world's top professors ",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
