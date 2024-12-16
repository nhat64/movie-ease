import 'package:json_annotation/json_annotation.dart';

part 'showtime_entity.g.dart';

@JsonSerializable()
class ShowtimeEntity {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'room_name')
  final String? name;

  @JsonKey(name: 'seat_count')
  final String? seatCount;

  ShowtimeEntity({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    this.name,
    this.seatCount,
  });

  factory ShowtimeEntity.fromJson(Map<String, dynamic> json) => _$ShowtimeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShowtimeEntityToJson(this);
}
