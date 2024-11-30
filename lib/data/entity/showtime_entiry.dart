import 'package:json_annotation/json_annotation.dart';

part 'showtime_entiry.g.dart';

@JsonSerializable()
class ShowtimeEntity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'movie_id')
  int? movieId;
  @JsonKey(name: 'room_id')
  int? roomId;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'cinema_id')
  int? cinemaId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'seat_map')
  String? seatMap;

  ShowtimeEntity({
    this.id,
    this.movieId,
    this.roomId,
    this.startTime,
    this.endTime,
    this.startDate,
    this.createdAt,
    this.updatedAt,
    this.cinemaId,
    this.name,
    this.seatMap,
  });

  factory ShowtimeEntity.fromJson(Map<String, dynamic> json) => _$ShowtimeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShowtimeEntityToJson(this);
}
