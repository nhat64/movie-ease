import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';

class SelectShowtimePageData {
  final MovieEntity? movie;
  final CinemaEntity cinema;

  SelectShowtimePageData({this.movie, required this.cinema});
}
