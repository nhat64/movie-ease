import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/showtime_entiry.dart';

class SelectSeatsPageData {
  final MovieEntity movie;
  final CinemaEntity cinema;
  final ShowtimeEntity showtime;

  SelectSeatsPageData({required this.movie, required this.showtime, required this.cinema});
}
