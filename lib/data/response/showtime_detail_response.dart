import 'package:base_flutter/data/entity/seat_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'showtime_detail_response.g.dart';

@JsonSerializable()
class ShowtimeDetailResponse {
  @JsonKey(name: 'room_name')
  String? roomName;

  @JsonKey(name: 'seat_list')
  List<List<SeatEntity>>? seatList;

  ShowtimeDetailResponse({
    this.roomName,
    this.seatList,
  });

  factory ShowtimeDetailResponse.fromJson(Map<String, dynamic> json) => _$ShowtimeDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShowtimeDetailResponseToJson(this);
}
