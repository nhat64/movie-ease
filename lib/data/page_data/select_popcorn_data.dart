import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/seat_entity.dart';
import 'package:base_flutter/data/entity/showtime_entity.dart';

class SelectPopcornPageData {

  final List<SeatEntity> selectedSeats;
  final CinemaEntity cinema;
  final MovieEntity movie;
  final ShowtimeEntity showtime;

  SelectPopcornPageData({required this.movie, required this.selectedSeats, required this.cinema, required this.showtime});
}