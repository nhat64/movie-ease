import 'package:base_flutter/data/entity/cinema_entity.dart';
import 'package:base_flutter/data/entity/movie_entity.dart';
import 'package:base_flutter/data/entity/showtime_entiry.dart';
import 'package:base_flutter/presentation/module/booking/select_seats/select_seats_controller.dart';

class PaymentPageData {
  final List<SeatEntity> selectedSeats;
  final CinemaEntity cinema;
  final MovieEntity movie;
  final ShowtimeEntity showtime;

  PaymentPageData({required this.movie, required this.selectedSeats, required this.cinema, required this.showtime});
}
