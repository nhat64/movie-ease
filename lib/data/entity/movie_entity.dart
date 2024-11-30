import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  final int id;
  final String poster;
  final String name;
  final String trailerUrl;
  final String date;
  final int duration;
  final String director;
  final List<String> movieGenre;
  final String rated;
  final String country;
  final String description;
  MovieEntity({
    this.id = 0,
    required this.poster,
    required this.name,
    required this.date,
    required this.duration,
    this.trailerUrl = 'youtube.com',
    this.director = 'Tên đạo diễn',
    this.movieGenre = const ['Hành động', 'Kinh dị', 'Hài hước'],
    this.rated = '18+',
    this.country = 'Việt Nam',
    this.description = 'Một bộ phim hay về một chuyến phiêu lưu của những người hùng, những tên cướp, những kẻ thù...',
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) => _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);
}

// {
//     "slug": "phim-test",
//     "genre_id": 1,
//     "country_id": 1,
//     "rated_id": 1,
//     "avatar": "test",
//     "performer": "Diễn viên chính",
//     "created_at": null,
//     "updated_at": null,
//   }

//  GoRouter.of(context).pop();