import 'package:base_flutter/data/entity/genre_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_entity.g.dart';

@JsonSerializable()
class BillEntity {
  @JsonKey(name: 'bill_id')
  int? billId;
  @JsonKey(name: 'cinema_name')
  String? cinemaName;
  @JsonKey(name: 'cinema_address')
  String? cinemaAddress;
  @JsonKey(name: 'movie_avatar')
  String? movieAvatar;
  @JsonKey(name: 'movie_name')
  String? movieName;
  @JsonKey(name: 'movie_genre')
  List<GenreEntity>? movieGenre;
  @JsonKey(name: 'movie_duration')
  String? movieDuration;
  @JsonKey(name: 'movie_rated')
  String? movieRated;
  @JsonKey(name: 'show_start_date')
  String? showStartDate;
  @JsonKey(name: 'show_start_time')
  String? showStartTime;
  @JsonKey(name: 'show_room')
  String? showRoom;
  @JsonKey(name: 'show_ticket_total')
  int? showTicketTotal;
  @JsonKey(name: 'show_seat')
  String? showSeat;
  @JsonKey(name: 'total_price')
  String? totalPrice;

  BillEntity({
    this.billId,
    this.cinemaName,
    this.cinemaAddress,
    this.movieAvatar,
    this.movieName,
    this.movieGenre,
    this.movieDuration,
    this.movieRated,
    this.showStartDate,
    this.showStartTime,
    this.showRoom,
    this.showTicketTotal,
    this.showSeat,
    this.totalPrice,
  });

  factory BillEntity.fromJson(Map<String, dynamic> json) => _$BillEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillEntityToJson(this);
}
