import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/showtime_entiry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_showtime_entity.g.dart';

@JsonSerializable()
class GroupShowtimeEntity {
  @JsonKey(name: 'movie')
  MovieEntity movie;

  @JsonKey(name: 'show_time')
  List<ShowtimeEntity> showtime;

  GroupShowtimeEntity({
    required this.movie,
    required this.showtime,
  });

  factory GroupShowtimeEntity.fromJson(Map<String, dynamic> json) => _$GroupShowtimeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GroupShowtimeEntityToJson(this);
}
