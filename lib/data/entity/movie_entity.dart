import 'package:base_flutter/data/entity/genre_entity.dart';
import 'package:base_flutter/data/entity/showtime_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  final int id;
  final String avatar;
  final String name;
  @JsonKey(name: 'trailer_url')
  final String trailerUrl;
  final String date;
  @JsonKey(name: 'duration')
  final String durationMinute;
  final String director;
  final List<GenreEntity> genre;
  final String rated;
  final String country;
  final String description;

  @JsonKey(name: 'vote_total')
  int voteTotal;
  @JsonKey(name: 'voting')
  String voting;
  @JsonKey(name: 'isEva')
  bool isEva;
  @JsonKey(name: 'seen_status')
  int seenStatus;

  // for select show time
  @JsonKey(name: 'show_time')
  List<ShowtimeEntity> showtime;

  MovieEntity({
    this.id = 0,
    required this.avatar,
    required this.name,
    required this.date,
    required this.durationMinute,
    this.trailerUrl = 'youtube.com',
    this.director = 'Tên đạo diễn',
    this.genre = const [],
    this.rated = '18+',
    this.country = 'Việt Nam',
    this.description = 'Một bộ phim hay về một chuyến phiêu lưu của những người hùng, những tên cướp, những kẻ thù...',
    this.showtime = const [],
    this.voteTotal = 0,
    this.voting = '0.0',
    this.isEva = false,
    this.seenStatus = 0,
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